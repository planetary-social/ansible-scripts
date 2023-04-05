# Nginx Single Host Role


This role sets up nginx, and the proper config, for a planetary room instance
where all the services are on a single host and share a domain. For example: the
host `planet.fun`` has
[go-ssb-room](https://github.com/planetary-social/go-ssb-room),
[planetary-graphql](https://github.com/planetary-social/planetary-graphql), and
[rooms-frontend](https://github.com/planetary-social/rooms-frontend) all running on it and they are accessible via `planet.name/login`,
`planet.name/graphql`, and `planet.name/` respectively.

This role depends on certbot-cloudflare to be run first, so that the
certificates referenced in the site config we copy over are already available on
the server.

Along with setting up the proxy, this role also expands the default config to
allow for better websocket connections and to gzip all text content passed
along, to help speed up the sites.

## The etc/hosts adjustments 
This role assumes its being run on one of our digital ocean droplets.  Our current pattern is to name the droplet after the url,
and then digital ocean sets this as the hostname in /etc/hosts.  This causes a name clash within our services cos of fun containerization [reasons](https://github.com/planetary-social/infrastructure/wiki/Planetary.name-update-report#what-is-happening).   The tasks around
/etc/hosts are just to remove this clash, and convert the hostname from `planet.fun` to `planetfun`

# Variables in this role

| variable | example    | purpose                                               |
| domain   | planet.fun | the fqdn of the host, should be set in your inventory |

