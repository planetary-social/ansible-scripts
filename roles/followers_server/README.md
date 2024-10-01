# followers_server role

This role sets up the followers.nos.social server to send follows and unfollows to the notification server

## Variables

| Variable                            | Example                                                      | Purpose                                                      |
|-----------------------------------  |--------------------------------------------------------------|--------------------------------------------------------------|
| domain                              | followers.nos.social                                      | The fqdn of the service                                      |
| cert_email                          | zach@nos.social                                              | The email used for the LetsEncrypt certificate               |
| followers_server_image           | ghcr.io/planetary-social/followers_server                 | The Docker image name                                        |
| followers_server_image_tag       | latest                                                       | The Docker image tag                                         |
| google_application_credentials      | /app/data/gcloud/application_default_credentials.json        | Google Cloud credentials location                            |
| followers_server_health_endpoint | https://{{ inventory_hostname }}/                            | Health check endpoint                                        |
