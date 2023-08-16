---
version: '3'
services:
  rsslay:
    image: ghcr.io/planetary-social/rsslay:stable
    container_name: rsslay
    volumes:
          - ./db:/db
    ports:
      - "0.0.0.0:{{ rsslay_port }}:8080"
    environment:
      - "SECRET={{ rsslay_secret_string }}"
      - "DB_DIR=/db/rsslay.sqlite"
      - "MAIN_DOMAIN_NAME={{ rsslay_domain }}"
    restart: always
