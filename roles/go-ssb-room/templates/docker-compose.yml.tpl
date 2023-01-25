---
version: '2.2'
services:
  room:
    image: {{ room_docker_image}}:{{ room_docker_tag }}
    environment:
      - "HTTPS_DOMAIN={{ inventory_hostname }}"
      - "ALIASES_AS_SUBDOMAINS={{ room_aliases_as_subdomains }}"
      - "BYPASS_INVITE_TOKEN={{ room_bypass_invite_token }}"
    ports:
      -  "{{ room_port }}:3000" # Proxypass this port through NGINX or Apache as your HTTP landing & dashboard page
      - "0.0.0.0:8008:8008" # This is the port SSB clients connect to
    volumes:
      - ./ssb-go-room-secrets:/ssb-go-room-secrets
