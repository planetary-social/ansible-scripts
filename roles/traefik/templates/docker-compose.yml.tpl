---
version: "3"

services:
  traefik:
    image: "traefik:v2.10"
    container_name: traefik
    restart: unless-stopped
    security_opt:
      - "no-new-privileges:true"
    env_file:
      - ./.env
    networks:
      - proxy
    command:
      # Enable insecure forwarded headers (safe because firewall only allows Cloudflare)
      - "--entrypoints.web.forwardedHeaders.insecure=true"
      - "--entrypoints.websecure.forwardedHeaders.insecure=true"
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - "/etc/localtime:/etc/localtime:ro"
      - "/var/run/docker.sock:/var/run/docker.sock:ro"
      - "./traefik.yml:/traefik.yml:ro"
      - "./acme.json:/acme.json"
      - "./configurations:/configurations"
    labels:
      - traefik.enable=true
      - traefik.docker.network=proxy
      - traefik.http.routers.traefik-secure.entrypoints=websecure
      - traefik.http.routers.traefik-secure.rule=Host(`{{ traefik_domain }}`)
      - traefik.http.routers.traefik-secure.service=api@internal
      - traefik.http.routers.traefik-secure.middlewares=user-auth@file

networks:
  proxy:
    external: true