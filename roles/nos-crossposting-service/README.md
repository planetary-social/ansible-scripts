# nos-crossposting-service Inventory

This role will deploy the nos_crossposting_service:

https://github.com/planetary-social/nos-crossposting-service/actions

It starts up a docker service running the given image tag (by default `latest`)
and a systemd job to regularly check for new versions of this image.

It also installs node-exporter, available at `{{domain}}:9100`

It's configuration is based on environment variables tied to inventory vars.  

they are:

``` txt
CROSSPOSTING_LISTEN_ADDRESS= ":{{ crossposting_listen_address }}"
CROSSPOSTING_METRICS_LISTEN_ADDRESS=":{{ crossposting_metrics_listen_address }}"
CROSSPOSTING_ENVIRONMENT="{{ crossposting_environment }}"
CROSSPOSTING_TWITTER_KEY="{{ crossposting_twitter_key }}"
CROSSPOSTING_TWITTER_KEY_SECRET="{{ crossposting_twitter_key_secret }}"
CROSSPOSTING_DATABASE_PATH="/db/database.sqlite"
CROSSPOSTING_LOG_LEVEL={{ crossposting_log_level }}
CROSSPOSTING_PUBLIC_FACING_ADDRESS={{ domain }}
```