EVENTS_LISTEN_ADDRESS= ":{{ events_listen_address }}"
EVENTS_ENVIRONMENT="{{ events_environment }}"
EVENTS_LOG_LEVEL={{ events_log_level }}
EVENTS_DATABASE_PATH="/db/database.sqlite"
EVENTS_GOOGLE_PUBSUB_PROJECT_ID="{{ events_google_pubsub_project_id }}"
EVENTS_GOOGLE_PUBSUB_CREDENTIALS_JSON_PATH="/certs/{{ events_google_pubsub_credentials_json }}"
EVENTS_PUBLIC_FACING_ADDRESS="https://{{ domain }}"