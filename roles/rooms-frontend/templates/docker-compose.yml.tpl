---
version: '2.2'
services:
  frontend:
    image: {{ frontend_docker_image }}:{{ frontend_docker_tag }}
    ports:
      - "{{ frontend_port }}:80"
