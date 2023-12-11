---
version: "3.3"

services:

  traefik:
    image: "traefik:v2.10"
    container_name: "traefik"
    command:
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false"
      - "--entrypoints.websecure.address=:443"
      - "--certificatesresolvers.nosresolver.acme.tlschallenge=true"
      - "--certificatesresolvers.nosresolver.acme.email={{ cert_email }}"
      - "--certificatesresolvers.nosresolver.acme.storage=/letsencrypt/acme.json"
    ports:
      - "443:443"
    volumes:
      - "./letsencrypt:/letsencrypt"
      - "/var/run/docker.sock:/var/run/docker.sock:ro"

  events:
    image: "{{ events_image }}:{{events_image_tag }}"
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
      - "traefik.http.routers.events.rule=Host(`{{ domain }}`)"
      - "traefik.http.routers.events.entrypoints=websecure"
      - "traefik.http.routers.events.tls.certresolver=nosresolver"