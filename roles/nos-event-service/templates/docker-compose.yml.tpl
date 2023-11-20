---
version: '3'
services:
  events:
    image: "{{ events_image }}:{{events_image_tag }}"
    container_name: events
    env_file:
     - ./.env
    volumes:
     - "./db:/db"
     - "./certs:/certs"
    ports:
      - "0.0.0.0:{{ events_listen_address }}:{{ events_listen_address }}"
    restart: always