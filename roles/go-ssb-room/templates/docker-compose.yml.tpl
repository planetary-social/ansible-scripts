---
version: '3'
services:
  room:
    image: zachboyofdestiny/go-ssb-room:1.1
    environment:
      - "HTTPS_DOMAIN={{ inventory_hostname }}"
      - "ALIASES_AS_SUBDOMAINS={{ admin_aliases_as_subdomains }}"
    ports:
      -  "{{ admin_port }}:3000" # Proxypass this port through NGINX or Apache as your HTTP landing & dashboard page
      - "0.0.0.0:8008:8008" # This is the port SSB clients connect to
    volumes:
      - ./ssb-go-room-secrets:/ssb-go-room-secrets
