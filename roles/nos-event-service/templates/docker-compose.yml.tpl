---
version: "3"

services:
  events:
    image: "{{ events_image }}:{{events_image_tag }}"
    networks:
      - proxy
    container_name: events
    env_file:
     - ./.env
    volumes:
     - "./db:/db"
     - "./certs:/certs"
    ports:
      - "0.0.0.0:{{ events_listen_address }}:{{ events_listen_address }}"
    restart: always
    labels:
      - "traefik.enable=true"
      - "traefik.docker.network=proxy"
      - "traefik.http.routers.nos_event_service.rule=Host(`{{ domain }}`)"
      - "traefik.http.routers.nos_event_service.entrypoints=websecure"
networks:
  proxy:
    external: true