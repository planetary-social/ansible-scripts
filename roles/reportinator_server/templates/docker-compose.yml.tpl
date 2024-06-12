---
version: "3.3"

services:
  reportinator_server:
    image: "{{ reportinator_server_image }}:{{ reportinator_server_image_tag }}"
    container_name: "reportinator_server"
    restart: always
    volumes:
      - {{ reportinator_server_dir }}/certs/{{ google_application_credentials }}:/certs/{{ google_application_credentials }}
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.reportinator_server.rule=Host(`{{ domain }}`)"
      - "traefik.http.routers.reportinator_server.entrypoints=websecure"
    environment:
      - RELAY_ADDRESSES_CSV={{ relay_addresses_csv }}
      - REPORTINATOR_SECRET={{ reportinator_secret }}
      - GOOGLE_APPLICATION_CREDENTIALS=/certs/{{ google_application_credentials }}
      - SLACK_SIGNING_SECRET={{ slack_signing_secret }}
      - SLACK_CHANNEL_ID=C06SBEF40G0
      - RUST_LOG=reportinator_server=info
    networks:
      - proxy

networks:
  proxy:
    external: true
