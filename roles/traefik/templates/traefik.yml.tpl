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
            sans: "{{ '*.' + domain }}"

  tcp-3000:
    address: ":3000"
  tcp-3001:
    address: ":3001"
  tcp-7687:
    address: ":7687"
  tcp-7474:
    address: ":7474"
  tcp-6362:
    address: ":6362"


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
