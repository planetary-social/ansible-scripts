# nostr-rs-relay role

This role sets up a nostr-rs-relay instance on a target server set up in front of a Traefik proxy and a nginx server for Webflow proxy_pass. Websocket and application/nostr+json requests are sent to nostr-rs-relay, the rest to our Webflow page at https://nos-relay.webflow.io/.

## Variables

| variable     | example            | purpose                    |
| ------------ | ------------------ | -------------------------- |
| domain       | relay.nos.social   | the fqdn of the service    |
| cert_email   | foo@bar.com        | the email used for the letsencrypt certificate |
| relay_image_tag | 0.9.4           | image tag for nostr-rs-relay |
