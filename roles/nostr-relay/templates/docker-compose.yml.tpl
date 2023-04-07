---
version: '3'
services:
  strfry-nostr-relay:
    image: cryptocartel/strfry:latest
    restart: unless-stopped
    volumes:
    - /home/{{ admin_username }}/relay/etc:/etc/
    - /home/{{ admin_username }}/relay/strfry-db:/app/strfry-db
    - /home/{{ admin_username }}/relay/plugins:/app/plugins
    ports:
    - "7777:7777"
