---
  relay:
    # Relay secret key (hex format)
    relay_secret_key: "{{ groups_relay_secret_key }}"
    local_addr: "0.0.0.0:8080"
    relay_url: "wss://{{ inventory_hostname }}"
    db_path: "/db/data"

    # Subscription limits
    # Maximum number of subscriptions per connection
    max_subscriptions: 50
    # Default/maximum limit for database queries (REQ filters)
    max_limit: 500

    # WebSocket settings
    websocket:
      # Maximum time a connection can stay open
      # Uses humantime format (e.g., "1h", "30m", "24h")
      max_connection_duration: "30m"
      # Idle timeout - disconnects after period of inactivity
      # Usually set to same value as max_connection_duration
      idle_timeout: "30m"
      # Maximum number of concurrent connections
      max_connections: 65000
