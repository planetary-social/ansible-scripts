# RSSLay role

This role sets up an rsslay instance on a target server set up with an nginx reverse proxy.  

We use docker-compose for our deployment, with an image generated automatically from https://github.com/planetary-social/rsslay

Along with setting up the nginx configuration for the site, this role also sets up a scheduled task that checks our registry
for a new version of our stable image, restarting the service with the updated image if necessary.

## Variables

| variable | example    | purpose                                               |
|----------|------------|-------------------------------------------------------|
| rsslay_domain   | rsslay_planet.fun | the fqdn of the service |
| rsslay_port   | 9018 | what port to map on the host to the container. |
| rsslay_secret_string   | oohchacha | any string, used for generating id's by rsslay |
