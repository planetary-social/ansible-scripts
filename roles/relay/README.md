# RSSLay role

This role sets up a strfry instance on a target server set up with an nginx reverse proxy.

We use docker-compose for our deployment, with an image generated automatically from https://github.com/planetary-social/localstrfry

Along with setting up the nginx configuration for the site, this role also sets up a scheduled task that checks our registry
for a new version of our stable image, restarting the service with the updated image if necessary.

## Variables

| variable     | example          | purpose                 |
| ------------ | ---------------- | ----------------------- |
| relay_domain | relay.nos.social | the fqdn of the service |
