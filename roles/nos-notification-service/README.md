# Nos Notification Service

This role sets up the [nos notification
service](https://github.com/planetary-social/nos-notification-service-go/) on an
ubuntu server.

It is assumed that server has already had the common and harden roles applied to it.  

## Variables
The variables follow the env vars needed for the servie as specified in the service's own [README](https://github.com/planetary-social/nos-notification-service-go#configuration).  It's recommended to read that first to understand these vars.


| variable                                      | example                                | purpose                          |
|-----------------------------------------------|----------------------------------------|----------------------------------|
| notifications_image_tag                       | stable                                 | which docker image to run        |
| notifications_nostr_listen_address            | 8008                                   | see service README               |
| notifications_metrics_listen_address          | 8009                                   | see service README               |
| notifications_firestore_project_id            | "nos-notification-service-dev"         | see service README               |
| notifications_firestore_credentials_json      | "some-service-account-3333-dev.json"   | see service README               |
| notifications_firestore_credentials_json_path | "/local/path/to/credentials_json_file" | location of cert on ansible host |
| notifications_apns_topic                      | "see.your.apple.account"               | see service README               |
| notifications_apns_certificate                | "certificate_apns.p12"                 | see service README               |
| notifications_apns_certificate_path           | "/local/path/to/apns/certificate"      | location of cert on ansible host |
| notifications_apns_certificate_password       | "password_you_set_for_apns_cert"       | see service README               |
| notifications_environment                     | "DEVELOPMENT"                          | see service README               |
| notifications_log_level                       | "DEBUG"                                | see service README               |
