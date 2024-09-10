api:
  dashboard: {{ traefik_dashboard_enabled }}

entryPoints:
  web:
    address: ":80"
    http:
      redirections:
        entryPoint:
          to: websecure

  websecure:
    address: ":443"
    http:
      middlewares:
        - secureHeaders@file
      tls:
        certResolver: letsencrypt
        domains:
          - main: "{{ domain }}"
            sans: "*.{{ domain }}"

  tcp-3001:
    address: ":3001"

providers:
  docker:
    endpoint: "unix:///var/run/docker.sock"
    exposedByDefault: false
  file:
    filename: /configurations/dynamic.yml

certificatesResolvers:
  letsencrypt:
    acme:
      dnschallenge:
        provider: cloudflare
        delayBeforeCheck: 0
      email: {{ cert_email }}
      storage: acme.json