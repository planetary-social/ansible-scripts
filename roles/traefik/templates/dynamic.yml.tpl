# Dynamic configuration
http:
  middlewares:
    secureHeaders:
      headers:
        sslRedirect: true
        forceSTSHeader: true
        stsIncludeSubdomains: true
        stsPreload: true
        stsSeconds: 31536000
    user-auth:
      basicAuth:
        users:
          - "{{ vault_traefik_user }}:{{ vault_traefik_password | password_hash(hashtype='md5') }}"