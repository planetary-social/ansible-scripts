reportinator:
  keys: {{ reportinator_secret }}
  relays: "wss://relay.nos.social"

slack:
  token: {{ slack_token }}
  channel_id: "C06SBEF40G0"
  signing_secret: {{ slack_signing_secret }}

http:
  bind_addr: '0.0.0.0'
  bind_port: 3000
  templates_dir: 'templates'