---
version: '2.2'
services:
  graphql:
    image: {{ graphql_docker_image }}:{{ graphql_docker_tag }}
    environment:
      - DB_PATH=/tmp/planetary-graphql
      - ROOM_HOST={{ inventory_hostname }}
      - ROOM_URL=https://{{ inventory_hostname }}
      - ROOM_PORT=8008
      - ROOM_KEY={{ admin_room_key }}
      - MAGIC_TOKEN={{ magic_token }}
      - LOGGING=true
      - BLOBS_URL=/blob/
      - NODE_ENV=production
    ports:
      - "{{ graphql_port }}:4000" # the graphql endpoint
      - "0.0.0.0:{{ graphql_blobs_port }}:26835" # the blob server
    volumes:
      - ./db:/tmp/planetary-graphql
