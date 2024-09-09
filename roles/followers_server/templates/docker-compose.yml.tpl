---
version: "3.3"

services:
  followers_server:
    image: "{{ followers_server_image }}:{{ followers_server_image_tag }}"
    container_name: "followers_server"
    ports:
     - "127.0.0.1:3001:3001" # 127.0.0.1 ensures it's only open locally, not exposed to the network
    environment:
      - APP__followers__neo4j_password={{ neo4j_password }}
      - APP__ENVIRONMENT=production
      - GOOGLE_APPLICATION_CREDENTIALS=/certs/{{ google_application_credentials }}
      - RUST_LOG=nos_followers=info
      - RUST_BACKTRACE=1
    volumes:
      - cargo-registry:/usr/local/cargo/registry
      - cargo-git:/usr/local/cargo/git/db
      - build-cache:/app/target
      - {{ followers_server_dir }}/certs/{{ google_application_credentials }}:/certs/{{ google_application_credentials }}
      - {{ followers_server_dir }}/config/settings.production.yml:/app/config/settings.production.yml
    labels:
      - "traefik.enable=true"

      # HTTP routing to port 3000
      - "traefik.http.routers.followers_server.rule=Host(`{{ domain }}`)"
      - "traefik.http.routers.followers_server.entrypoints=websecure"
      - "traefik.http.services.followers_server.loadbalancer.server.port=3000"

      # TCP routing to port 3001
      - "traefik.tcp.routers.tcp_followers_server.rule=HostSNI(`{{ domain }}`)"
      - "traefik.tcp.routers.tcp_followers_server.entrypoints=tcp-3001"
      #- "traefik.tcp.routers.tcp_followers_server.tls=true"
      - "traefik.tcp.services.tcp_followers_server.loadbalancer.server.port=3001"

      # Whitelist only IP of relay.nos.social. This was not working when the
      # 3001 port was exposed, don't know why
      - "traefik.tcp.middlewares.tcp_ipwhitelist.ipwhitelist.sourcerange=104.236.196.139/32"
      - "traefik.tcp.routers.tcp_followers_server.middlewares=tcp_ipwhitelist"


    depends_on:
      db:
        condition: service_healthy
    restart: always
    networks:
      - proxy

  db:
    # 5.23 has no graph-data-science plugin yet
    image: neo4j:5.22
    platform: linux/amd64
    environment:
      - NEO4J_AUTH=neo4j/{{ neo4j_password }}
      - NEO4J_apoc_export_file_enabled=true
      - NEO4J_apoc_import_file_enabled=true
      - NEO4J_apoc_import_file_use__neo4j__config=true
      - NEO4J_PLUGINS=["apoc", "graph-data-science"]
      - NEO4J_dbms_default__advertised__address={{ domain }}
      - NEO4J_dbms_connector_bolt_advertised__address=:443
    volumes:
      - db-data:/data
      - db-logs:/logs
      - db-import:/var/lib/neo4j/import
      - db-plugins:/plugins
    labels:
      - "traefik.enable=true"

      # HTTP routing for Neo4j Browser (port 7474)
      - "traefik.http.routers.neo4j.entrypoints=websecure"
      - "traefik.http.routers.neo4j.rule=Host(`{{ domain }}`) && ((PathPrefix(`/neo4j`) || PathPrefix(`/browser`)))"
      - "traefik.http.routers.neo4j.tls=true"
      - "traefik.http.routers.neo4j.middlewares=neo4j_strip"
      - "traefik.http.middlewares.neo4j_strip.stripprefix.prefixes=/neo4j"
      - "traefik.http.services.neo4j.loadbalancer.server.port=7474"

      # TCP routing for Neo4j Bolt (port 7687). TLS is not working for this
      # port, I think that's the reason the conection from the browser is not
      # working
      - "traefik.tcp.routers.neo4jdb.entrypoints=tcp-7687"
      - "traefik.tcp.routers.neo4jdb.rule=HostSNI(`{{ domain }}`)"
      - "traefik.tcp.routers.neo4jdb.tls=true"
      - "traefik.tcp.services.neo4jdb.loadbalancer.server.port=7687"

    healthcheck:
      test: wget http://localhost:7474 || exit 1
      interval: 10s
      timeout: 10s
      retries: 10
      start_period: 60s
    networks:
      - proxy


volumes:
  db-data:
  db-logs:
  db-import:
  db-plugins:
  cargo-registry:
  cargo-git:
  build-cache:

networks:
  proxy:
    external: true
