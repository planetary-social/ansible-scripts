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

  api:
    image: "{{ nos_api_image }}:{{ nos_api_image_tag }}"
    container_name: "api"
    restart: always
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.api.rule=Host(`{{ domain }}`) && (PathPrefix(`/api/`) || PathPrefix(`/.well-known`))"
      - "traefik.http.services.redirect-service.loadbalancer.server.port=8080"


  redirect-service:
    image: nginx:alpine
    container_name: "redirect-service"
    restart: always
    volumes:
      - ./nginx-redirect.conf:/etc/nginx/conf.d/default.conf
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.redirect-service.rule=Host(`{{ domain }}`) && !PathPrefix(`/.well-known`)"
      - "traefik.http.services.redirect-service.loadbalancer.server.port=80"