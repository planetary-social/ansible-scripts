---
version: '3'
services:
  graphql:
    image: zachboyofdestiny/planetary-graphql:1.0
    environment:
      - DB_PATH=/tmp/planetary-graphql
      - ROOM_HOST={{ inventory_hostname }}
      - ROOM_URL=https://{{ inventory_hostname }}
      - ROOM_PORT=8008
      - ROOM_KEY={{ admin_room_key }}
      - MAGIC_TOKEN={{ magic_token }}
      - LOGGING=true
      - BLOBS_URL=http://0.0.0.0:26835
    ports:
      - "4000:4000" # the graphql endpoint
      - "0.0.0.0:26835:26835" # the blob server
    volumes:
      - ./db:/tmp/planetary-graphql
