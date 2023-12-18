# traefik

Deploys traefik to a server at the given `traefik_domain`.   If none is given, it deploys it to `traefik.{ inventory_hostname }`

It deploys it using docker compose and, as part of this role, creates a network called `proxy`.

This is useful for other roles that deploy the service as a docker compose file,
as you can handle the routing and tls setup via traefik labels.  


To use this within another role, add it as a dependency.  Then, when defining apps within a docker compose, you can write them as:

``` yaml
---
version: '3'
services:
  events:
    image: "myapp:latest"
    container_name: myapp
    env_file:
     - ./.env
    ports:
      - "0.0.0.0:8008:8008"
    networks:
     - proxy
    restart: always
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.myapp.rule=Host(`myapp.mydomain.com`)"
      - "traefik.http.routers.myapp.entrypoints=websecure"
      - "traefik.http.routers.myapp.tls.certresolver=nosresolver"
networks:
  proxy:
    external: true

```

And they'll be automatically picked up by the traefik proxy, with routing and certs handled by it.



