---
relay:
  # Relay secret key (hex format)
  relay_secret_key: "{{ groups_relay_secret_key }}"
  local_addr: "0.0.0.0:8080"
  relay_url: "wss://{{ inventory_hostname }}"
  db_path: "/db/data"

  # WebSocket settings
  websocket:
    # Size of the channel for outbound messages (default: 1000)
    channel_size: 1000
    # Maximum time a connection can stay open (optional)
    # Uses humantime format (e.g., "1h", "30m", "24h")
    max_connection_time: "30m"
    # Maximum number of concurrent connections (optional)
    max_connections: 65000
