---
version: '3'
services:
  notifications:
    image: {{ notifications_image }}:{{notifications_image_tag }}
    container_name: notifications
    env_file:
      - ./.env
    volumes:
      - "./certs:/certs"
    ports:
      - "0.0.0.0:{{ notifications_nostr_listen_address }}:{{ notifications_nostr_listen_address }}"
      - "0.0.0.0:{{ notifications_metrics_listen_address }}:{{ notifications_metrics_listen_address }}"
    restart: always
