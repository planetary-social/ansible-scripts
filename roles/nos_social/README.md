# nos_social role

This role sets up the nos.social homepage and prepares for a future service to provide the nip 05 service. It uses a Traefik proxy and a nginx server for Webflow proxy_pass to https://nos_social.webflow.io/. 

## Traefik settings

All our traefik rules are defined in the docker-compose file contained in this role's templates folder. 
We are currently defining rules for redirection and rate limiting.

### Redirect rules 
There are two primary services running as part of this role: the nip05 api service and an nginx proxy acting as the redirect service.

For incoming requests, any that have to do with api calls are sent to the api service (the exact paths can be read in the compose file).
Any requests to the bare domain are redirected to the site hosted on webflow.
Any name requests (e.g. daniel.nos.social) redirect to the profile page at njump.me (e.g. njump.me/daniel@nos.social)

### Rate Limiting
We have rate limiting middleware as specified [in traefik's docs](https://doc.traefik.io/traefik/middlewares/http/ratelimit/#configuration-example)
This is to help control the rate in which new names are created via the nip05 api.


## Variables

| variable                   | example                           | purpose                                                     |
|----------------------------|-----------------------------------|-------------------------------------------------------------|
| domain                     | nos.social                        | the fqdn of the service                                     |
| cert_email                 | foo@bar.com                       | the email used for the letsencrypt certificate              |
| nip05api_image             | ghcr.io/planetary-social/nip05api | the docker image name                                       |
| nip05api_image_tag         | latest                            | the docker image tag                                        |
| nip05api_node_env          | production                        | whether app should be development or production             |
| nip05api_auth_pubkey       | some long string                  | the public nostr key used to sign messages                  |
| slack_webhook_url          | https://slack/somesecret          | held in vault, webhook used to send alerts to our workspace |
| nip05api_ratelimit_average | 120                               | average rate of requests allowed to api service             |
| nip05api_ratelimit_burst   | 200                               | the max number of requests allowed to go through at once    |



