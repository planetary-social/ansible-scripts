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

  nostrface:
    image: "{{ nostrface_image }}:{{ nostrface_image_tag }}"
    container_name: "nostrface"
    restart: always
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.nostrface.rule=Host(`{{ domain }}`)"
      - "traefik.http.routers.nostrface.entrypoints=websecure"
      - "traefik.http.routers.nostrface.tls.certresolver=nosresolver"
