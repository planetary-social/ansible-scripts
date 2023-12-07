# nos-event-service Inventory

This role will deploy the nos_events_service:

https://github.com/planetary-social/nos-event-service

It starts up a docker service running the given image tag (by default `latest`)
and a systemd job to regularly check for new versions of this image.

It's configuration is based on environment variables tied to inventory vars.

they are:

``` txt
EVENTS_LISTEN_ADDRESS= ":{{ events_listen_address }}"
EVENTS_ENVIRONMENT="{{ events_environment }}"
EVENTS_DATABASE_PATH="/db/database.sqlite"
EVENTS_LOG_LEVEL={{ events_log_level }}
EVENTS_PUBLIC_FACING_ADDRESS={{ domain }}
```