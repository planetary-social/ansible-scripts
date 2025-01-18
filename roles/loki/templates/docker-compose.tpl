version: '3'
services:
  loki:
    image: grafana/loki  # TODO: Pin rather than latest
    container_name: loki
    mem_limit: 6g
    cpus: 2.0
    ports:
      - "0.0.0.0:3100:3100"
    volumes:
      - "./loki-config.yaml:/etc/loki/local-config.yaml"
    networks:
     - proxy
    restart: always
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.loki.rule=Host(`loki.planetary.tools`)"
      - "traefik.http.routers.loki.entrypoints=websecure"
      - "traefik.http.routers.loki.tls.certresolver=nosresolver"
      - "traefik.http.middlewares.loki-auth.basicauth.users=verse:{{ loki_password_hashed_escaped }}"
      - "traefik.http.routers.loki.middlewares=loki-auth"
networks:
  proxy:
    external: true