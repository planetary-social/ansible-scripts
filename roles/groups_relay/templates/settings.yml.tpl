---
relay:
  # Relay secret key (hex format)
  relay_secret_key: "{{ groups_relay_secret_key }}"
  local_addr: "0.0.0.0:8080"
  auth_url: "wss://{{ inventory_hostname }}"
  relay_url: "ws://localhost:8080"
  db_path: "/db/data"