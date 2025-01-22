version: '3'
services:
  loki:
    image: grafana/loki  # TODO: Pin rather than latest
    container_name: loki
    mem_limit: 6g
    cpus: 2.0
    ports:
      - "3100:3100"
    volumes:
      - "./loki-config.yaml:/etc/loki/local-config.yaml"
    networks:
     - proxy
    restart: always
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.loki.rule=Host(`loki.planetary.tools`)"
      - "traefik.http.routers.loki.entrypoints=websecure"
      - "traefik.http.routers.loki.tls.certresolver=letsencrypt"
      - "traefik.http.middlewares.user-auth.basicauth.users={{ vault_traefik_user }}:{{ vault_traefik_password | password_hash(hashtype='md5') }}"
      - "traefik.http.services.loki.loadbalancer.server.port=3100"
networks:
  proxy:
    external: true