# nos-social role

This role sets up the nos.social homepage and prepares for a future service to provide the nip 05 service. It uses a Traefik proxy and a nginx server for Webflow proxy_pass to https://nos-social.webflow.io/. 

## Variables

| variable     | example            | purpose                    |
| ------------ | ------------------ | -------------------------- |
| domain       | nos.social   | the fqdn of the service    |
| cert_email   | foo@bar.com        | the email used for the letsencrypt certificate |
