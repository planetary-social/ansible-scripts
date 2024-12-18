services:
  groups_relay:
    container_name: groups_relay
    image: "{{ groups_relay_image }}:{{ groups_relay_image_tag }}"
    platform: linux/amd64
    volumes:
      - ./config:/app/config:ro
    environment:
      RUST_LOG: "${RUST_LOG:-info}"
      RUST_BACKTRACE: 1
      NIP29__ENVIRONMENT: production
      NIP29__relay__relay_url: "ws://strfry:7777"
    ports:
      - "8080:8080"
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.groups_relay.rule=Host(`{{ domain }}`)"
      - "traefik.http.routers.groups_relay.entrypoints=websecure"
      - "traefik.http.services.groups_relay.loadbalancer.server.port=8080"
    depends_on:
      strfry:
        condition: service_started
    restart: always
    networks:
      - proxy

  strfry:
    container_name: strfry
    image: ghcr.io/hoytech/strfry:latest
    platform: linux/amd64
    volumes:
      - strfry-data:/strfry/data
      - ./config/strfry.conf:/etc/strfry.conf:ro
    command: relay --config /etc/strfry.conf
    restart: always
    networks:
      - proxy

volumes:
  strfry-data:

networks:
  proxy:
    external: true
