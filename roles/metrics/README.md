# Metrics Task

A role for setting up our metric services on a planetary server.  It will clone our metrics repo--which sets up Prometheus,Grafana, and Ansible--and then set up the necessary nginx files to make them accessible on the web.

# Ansible dependencies
This role assumes a newly made server that has had the hardening role run on it.
It then depends on the roles:
- docker
- digitalocean
- cloudflare-certbot
- nginx

These dependencies are built into the role(see the meta/main.yaml file).

The cloudflare-certbot role assumes you're hosting the base domain on cloudflare, and have pointed it and the subdomains to your server's ip address _before_ running this role.

# Variables in this role

