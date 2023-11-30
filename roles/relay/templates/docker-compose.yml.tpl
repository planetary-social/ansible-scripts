---
version: "3.3"

services:

  traefik:
    image: "traefik:v2.10"
    container_name: "traefik"
    command:
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false"
      - "--entrypoints.web.address=:443"
      - "--certificatesresolvers.nosresolver.acme.tlschallenge=true"
      - "--certificatesresolvers.nosresolver.acme.email={{ cert_email }}"
      - "--certificatesresolvers.nosresolver.acme.storage=/letsencrypt/acme.json"
    ports:
      - "443:443"
    volumes:
      - "/var/run/docker.sock:/var/run/docker.sock:ro"

  strfry:
    image: relayable/strfry:latest
    container_name: "strfry"
    restart: always
    volumes:
      - ./strfry/config/strfry.conf:/etc/strfry.conf
      - ./strfry/db:/app/strfry-db
      - ./strfry/plugins:/app/plugins
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.strfry.rule=Headers(`Accept`, `application/nostr+json`) || HeadersRegexp(`Connection`, `(?i)Upgrade`)" #" && HeadersRegexp(`Upgrade`, `websocket`)"
      - "traefik.http.routers.strfry.entrypoints=websecure"
      - "traefik.http.routers.strfry.tls.certresolver=nosresolver"
      - "traefik.http.services.strfry.loadbalancer.server.port=7777"

  redirect-service:
    image: nginx:alpine
    container_name: "redirect-service"
    restart: always
    volumes:
      - ./redirect-service/nginx-redirect.conf:/etc/nginx/conf.d/default.conf
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.redirect-service.rule=Host(`localhost`)"
      - "traefik.http.routers.redirect-service.entrypoints=websecure"
      - "traefik.http.routers.redirect-service.tls.certresolver=nosresolver"
      - "traefik.http.services.redirect-service.loadbalancer.server.port=80"

