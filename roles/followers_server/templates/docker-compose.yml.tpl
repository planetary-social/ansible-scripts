---
version: "3.3"

services:
  followers_server:
    image: "{{ followers_server_image }}:{{ followers_server_image_tag }}"
    container_name: "followers_server"
    environment:
      - APP__NEO4J_URI=db:7687
      - APP__NEO4J_USER=neo4j
      - APP__NEO4J_PASSWORD={{ neo4j_password }}
      - GOOGLE_APPLICATION_CREDENTIALS=/certs/{{ google_application_credentials }}
      - RUST_LOG=nos_followers=info
      - RUST_BACKTRACE=1
    volumes:
      - cargo-registry:/usr/local/cargo/registry
      - cargo-git:/usr/local/cargo/git/db
      - build-cache:/app/target
      - {{ followers_server_dir }}/certs/{{ google_application_credentials }}:/certs/{{ google_application_credentials }}
      - {{ followers_server_dir }}/config/settings.yml:/app/config/settings.yml
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.followers_server.rule=Host(`{{ domain }}`)"
      - "traefik.http.routers.followers_server.entrypoints=websecure"
    depends_on:
      db:
        condition: service_healthy
    restart: always
    networks:
      - proxy

  db:
    image: neo4j:latest
    platform: linux/amd64
    ports:
      - 7474:7474
    expose:
      - 7687  # Expose the Bolt protocol internally only
    environment:
      - NEO4J_AUTH=neo4j/{{ neo4j_password }}
      - NEO4J_apoc_export_file_enabled=true
      - NEO4J_apoc_import_file_enabled=true
      - NEO4J_apoc_import_file_use__neo4j__config=true
      - NEO4J_PLUGINS=["apoc", "graph-data-science"]
    volumes:
      - db-data:/data
      - db-logs:/logs
      - db-import:/var/lib/neo4j/import
      - db-plugins:/plugins
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.db.entrypoints=websecure"
      - "traefik.http.routers.db.rule=Host(`daniel.dev.nos.social`) && PathPrefix(`/db`)"
      - "traefik.http.middlewares.db-strip.stripprefix.prefixes=/db"
      - "traefik.http.routers.db.middlewares=db-strip"
      - "traefik.http.services.db.loadbalancer.server.port=7474"

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
