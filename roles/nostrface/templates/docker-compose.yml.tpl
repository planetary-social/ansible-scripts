---
version: '3'
services:
  nostrface:
    image: {{ nostrface_image }}:{{nostrface_image_tag }}
    container_name: nostrface
    ports:
      - "0.0.0.0:{{ nostrface_listen_address }}:{{ nostrface_listen_address }}"
    restart: always
