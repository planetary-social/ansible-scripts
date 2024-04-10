---
version: "3.3"

services:
  reportinator_server:
    image: "{{ reportinator_server_image }}:{{ reportinator_server_image_tag }}"
    container_name: "reportinator_server"
    restart: always
    volumes:
      - data:/app/data
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.reportinator_server.rule=Host(`{{ domain }}`)"
      - "traefik.http.routers.reportinator_server.entrypoints=websecure"
      - "traefik.http.routers.reportinator_server.tls.certresolver=nosresolver"


volumes:
  data:

networks:
  proxy:
    external: true
