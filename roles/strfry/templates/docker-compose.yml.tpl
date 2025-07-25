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
      - "--entrypoints.websecure.http.tls.certResolver=nosresolver"
      - "--entrypoints.web.address=:80"
      - "--entrypoints.web.http.redirections.entryPoint.to=websecure"
      - "--entrypoints.web.http.redirections.entryPoint.scheme=https"
      - "--entrypoints.web.http.redirections.entrypoint.permanent=true"
      - "--certificatesresolvers.nosresolver.acme.tlschallenge=true"
      - "--certificatesresolvers.nosresolver.acme.email={{ cert_email }}"
      - "--certificatesresolvers.nosresolver.acme.storage=/letsencrypt/acme.json"
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - "./letsencrypt:/letsencrypt"
      - "/var/run/docker.sock:/var/run/docker.sock:ro"


  strfry:
    image: "{{ relay_server_image }}:{{ relay_image_tag }}"
    container_name: "strfry"
    restart: always
{% if relay_sync_peers is defined %}
    ports:
      - "7777:7777"  # Expose for relay-to-relay sync
{% endif %}
    volumes:
      - ./strfrydb:/app/strfry-db # Strfry data
      - ./data:/usr/src/app/db    # nostr-rs-relay data for the olympics relay, there's now a specific role for this: nostr-rs-relay
      - ./strfry.conf:/etc/strfry.conf:ro
      - ./strfry-router.conf:/etc/strfry-router.conf:ro
    environment:
      - RELAY_URL=wss://{{ domain }}
      - REDIS_URL={{ redis_url }}
      - WHITELIST_IPS={{ relay_sync_peers | default([]) | join(',') }}
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.strfry.rule=Host(`{{ domain }}`) && Headers(`Accept`, `application/nostr+json`) || HeadersRegexp(`Connection`, `(?i)Upgrade`) && HeadersRegexp(`Upgrade`, `websocket`)"
      - "traefik.http.routers.strfry.entrypoints=websecure"
      - "traefik.http.services.strfry.loadbalancer.server.port=7777"


  redirect-service:
    image: nginx:alpine
    container_name: "redirect-service"
    restart: always
    volumes:
      - ./nginx-redirect.conf:/etc/nginx/conf.d/default.conf
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.redirect-service.rule=Host(`{{ domain }}`) && !PathPrefix(`/dashboard`)"
      - "traefik.http.routers.redirect-service.entrypoints=websecure"
      - "traefik.http.services.redirect-service.loadbalancer.server.port=80"
