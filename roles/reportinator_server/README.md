# reportinator_server role

This role sets up the reportinator.nos.social server to handle encrypted DMs for moderation requests.

## Variables

| Variable                            | Example                                                      | Purpose                                                      |
|-----------------------------------  |--------------------------------------------------------------|--------------------------------------------------------------|
| domain                              | reportinator.nos.social                                      | The fqdn of the service                                      |
| cert_email                          | zach@nos.social                                              | The email used for the LetsEncrypt certificate               |
| reportinator_server_image           | ghcr.io/planetary-social/reportinator_server                 | The Docker image name                                        |
| reportinator_server_image_tag       | latest                                                       | The Docker image tag                                         |
| google_application_credentials      | /app/data/gcloud/application_default_credentials.json        | Google Cloud credentials location                            |
| relay_addresses_csv                 | wss://relay.nos.social                                       | Relay to listen to DMs                                       |
| reportinator_server_health_endpoint | https://{{ inventory_hostname }}/                            | Health check endpoint                                        |
| reportinator_secret                 | some nostr hex secret                                        | The secret for the Reportinator account, held in vault       |
| slack_signing_secret                | some long string                                             | The secret to interact with Slack, held in vault             |
