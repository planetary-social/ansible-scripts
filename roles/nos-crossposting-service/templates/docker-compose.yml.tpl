---
version: '3'
services:
  crossposting:
    image: "{{ crossposting_image }}:{{crossposting_image_tag }}"
    container_name: crossposting
    env_file:
      - ./.env
    volumes:
      - "./db:/db"
    ports:
      - "0.0.0.0:{{ crossposting_listen_address }}:{{ crossposting_listen_address }}"
      - "0.0.0.0:{{ crossposting_metrics_listen_address }}:{{ crossposting_metrics_listen_address }}"
    restart: always