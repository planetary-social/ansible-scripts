---
version: "3.3"

services:


  traefik:
    image: "traefik:v2.10"
    container_name: "traefik"
    command:
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false"
      - "--api.dashboard=true"
      - "--entrypoints.websecure.address=:443"
      - "--entrypoints.web.http.redirections.entryPoint.to=websecure"
      - "--entrypoints.web.http.redirections.entryPoint.scheme=https"
      - "--entrypoints.web.http.redirections.entrypoint.permanent=true"
      - "--certificatesresolvers.nosresolver.acme.tlschallenge=true"
      - "--certificatesresolvers.nosresolver.acme.email={{ cert_email }}"
      - "--certificatesresolvers.nosresolver.acme.storage=/letsencrypt/acme.json"
     
    ports:
      - "443:443"
    volumes:
      - "./letsencrypt:/letsencrypt"
      - "/var/run/docker.sock:/var/run/docker.sock:ro"
    labels:
      - "traefik.http.routers.api.rule=Host(`{{ domain }}`) && PathPrefix(`/dashboard`)"
      - "traefik.http.routers.api.service=api@internal"
      - "traefik.http.routers.api.entrypoints=websecure"
      - "traefik.http.routers.api.tls.certresolver=nosresolver"
      - "traefik.http.routers.api.middlewares=dashboard-stripprefix,auth"
      - "traefik.http.middlewares.dashboard-stripprefix.stripprefix.prefixes=/dashboard"
      - "traefik.http.middlewares.auth.basicauth.users=admin:$$apr1$$yDShC2bf$$Hz77GyRSmTrHrF/gCaHci1"



  strfry:
    image: relayable/strfry:latest
    container_name: "strfry"
    restart: always
    volumes:
      - ./strfry.conf:/etc/strfry.conf
      - ./strfrydb:/app/strfry-db
      - ./whitelist.js:/app/plugins/whitelist.js
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.strfry.rule=Host(`{{ domain }}`) && Headers(`Accept`, `application/nostr+json`) || HeadersRegexp(`Connection`, `(?i)Upgrade`) && HeadersRegexp(`Upgrade`, `websocket`)"
      - "traefik.http.routers.strfry.entrypoints=websecure"
      - "traefik.http.routers.strfry.tls=true"
      - "traefik.http.routers.strfry.tls.certresolver=nosresolver"
      - "traefik.http.services.strfry.loadbalancer.server.port=7777"


  redirect-service:
    image: nginx:alpine
    container_name: "redirect-service"
    restart: always
    volumes:
      - ./nginx-redirect.conf:/etc/nginx/conf.d/default.conf
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.redirect-service.rule=Host(`{{ domain }}`)"
      - "traefik.http.routers.redirect-service.entrypoints=websecure"
      - "traefik.http.routers.redirect-service.tls=true"
      - "traefik.http.routers.redirect-service.tls.certresolver=nosresolver"
      - "traefik.http.services.redirect-service.loadbalancer.server.port=80"
