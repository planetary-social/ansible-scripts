---
version: "3.3"

services:
  redis:
    image: redis:7.2.4
    ports:
      - "127.0.0.1:6379:6379"
    command: redis-server --loglevel notice
    volumes:
      - redis_data:/data
    networks:
      - proxy

  api:
    image: "{{ nip05api_image }}:{{ nip05api_image_tag }}"
    container_name: "api"
    restart: always
    env_file:
      - ./.env
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.nip05api.rule=PathPrefix(`/metrics`) || PathPrefix(`/api/`) || PathPrefix(`/.well-known`)"
      - "traefik.http.routers.nip05api.entrypoints=websecure"
      - "traefik.http.middlewares.nip05api.ratelimit.average={{ nip05api_ratelimit_average }}"
      - "traefik.http.middlewares.nip05api.ratelimit.burst={{ nip05api_ratelimit_burst }}"
    depends_on:
      - redis
    networks:
      - proxy

  redirect-service:
    image: nginx:1.25.3-alpine
    container_name: "redirect-service"
    restart: always
    volumes:
      - ./nginx-redirect.conf:/etc/nginx/conf.d/default.conf
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.redirect-service.entrypoints=websecure"
      - "traefik.http.routers.redirect-service.rule=!PathPrefix(`/metrics`) && !PathPrefix(`/api/`) && !PathPrefix(`/.well-known`)"
    networks:
      - proxy

volumes:
  redis_data:

networks:
  proxy:
    external: true
