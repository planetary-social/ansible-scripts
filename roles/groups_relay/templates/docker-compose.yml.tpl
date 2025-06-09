services:
  groups_relay:
    container_name: groups_relay
    image: "{{ groups_relay_image }}:{{ groups_relay_image_tag }}"
    platform: linux/amd64
    volumes:
      - ./config:/app/config:ro
      - db-data:/db/data
    environment:
      RUST_LOG: {{ groups_relay_log_level }}
    {% if groups_relay_rust_backtrace_enabled is defined and groups_relay_rust_backtrace_enabled %}
      RUST_BACKTRACE: full
    {% endif %}
      RUST_BACKTRACE: 1
      NIP29__ENVIRONMENT: production
    ports:
      - "8080:8080"
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.groups_relay.rule=Host(`{{ domain }}`) || HostRegexp(`{subdomain:[a-z0-9-]+}.{{ domain }}`)"
      - "traefik.http.routers.groups_relay.entrypoints=websecure"
      - "traefik.http.services.groups_relay.loadbalancer.server.port=8080"
    restart: always
    networks:
      - proxy

volumes:
  db-data:

networks:
  proxy:
    external: true
