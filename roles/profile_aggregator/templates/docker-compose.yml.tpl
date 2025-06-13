version: '3.8'

services:
  profile_aggregator:
    image: {{ profile_aggregator_image }}:{{ profile_aggregator_image_tag }}
    container_name: profile_aggregator
    platform: linux/amd64
    restart: unless-stopped
    environment:
      - RUST_LOG={{ profile_aggregator_log_level }}
{% if profile_aggregator_rust_backtrace_enabled is defined and profile_aggregator_rust_backtrace_enabled %}
      - RUST_BACKTRACE=full
{% endif %}
      - RELAY_URL={{ profile_aggregator_relay_url }}
      - RELAY_CONTACT={{ profile_aggregator_relay_contact }}
      - RELAY_SECRET_KEY={{ profile_aggregator_secret_key }}
      - DISCOVERY_RELAY_URL={{ profile_aggregator_discovery_relay_url }}
      - BIND_ADDR={{ profile_aggregator_bind_addr }}
      - PAGE_SIZE={{ profile_aggregator_page_size }}
      - INITIAL_BACKOFF_SECS={{ profile_aggregator_initial_backoff_secs }}
      - MAX_BACKOFF_SECS={{ profile_aggregator_max_backoff_secs }}
      - WORKER_THREADS={{ profile_aggregator_worker_threads }}
      - DATABASE_PATH={{ profile_aggregator_database_path }}
      - STATE_FILE={{ profile_aggregator_state_file }}
    volumes:
      - ./data:/data
    ports:
      - "127.0.0.1:8080:8080"
    labels:
      - "traefik.enable=true"
      - "traefik.http.routers.profile_aggregator.rule=Host(`{{ inventory_hostname }}`)"
      - "traefik.http.routers.profile_aggregator.entrypoints=websecure"
      - "traefik.http.routers.profile_aggregator.tls=true"
      - "traefik.http.routers.profile_aggregator.tls.certresolver=letsencrypt"
      - "traefik.http.services.profile_aggregator.loadbalancer.server.port=8080"
      - "traefik.http.routers.profile_aggregator.service=profile_aggregator"
      # WebSocket support
      - "traefik.http.middlewares.profile_aggregator-headers.headers.customrequestheaders.X-Forwarded-Proto=https"
      - "traefik.http.routers.profile_aggregator.middlewares=profile_aggregator-headers"
    networks:
      - proxy
    logging:
      driver: "json-file"
      options:
        max-size: "10m"
        max-file: "3"

networks:
  proxy:
    external: true