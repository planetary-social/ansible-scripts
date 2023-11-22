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
  cadvisor:
      image: gcr.io/cadvisor/cadvisor:latest
      restart: unless-stopped
      container_name: cadvisor
      ports:
      - 8080:8080
      volumes:
      - /:/rootfs:ro
      - /var/run:/var/run:rw
      - /sys:/sys:ro
      - /var/lib/docker/:/var/lib/docker:ro
