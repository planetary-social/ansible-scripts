services:
  groups_relay:
    container_name: groups_relay
    image: "{{ groups_relay_image }}:{{ groups_relay_image_tag }}"
    platform: linux/amd64
    volumes:
      - ./config:/app/config:ro
      - db-data:/db/data
    environment:
      RUST_LOG: info
      RUST_BACKTRACE: 1
      NIP29__ENVIRONMENT: production
    ports:
      - "8080:8080"
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.groups_relay.rule=Host(`{{ domain }}`)"
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
