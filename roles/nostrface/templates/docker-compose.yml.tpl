---
version: "3"

services:
  nostrface:
    image: "{{ nostrface_image }}:{{ nostrface_image_tag }}"
    networks:
      - proxy
    container_name: "nostrface"
    restart: always
    labels:
      - "traefik.enable=true"
      - "traefik.docker.network=proxy"
      - "traefik.http.routers.nostrface.rule=Host(`{{ domain }}`)"
      - "traefik.http.routers.nostrface.entrypoints=websecure"
networks:
  proxy:
    external: true