# Certbot and Cloudflare Role

This role uses certbot, and the cloudflare api, to setup ssl certificates for a
given server.

It will only create the certificates and put them in the right place. You can
then reference them in something like the nginx-single-host role, where the
configuration the role copies onto the server references the certificates made here.

This role requires a cloudflare account, with the domains held by cloudflare.  You 
can sign up for a free plan here: https://www.cloudflare.com/. It also requires creating
an [Edit Zone DNS token in your cloudflare dashboard](https://developers.cloudflare.com/fundamentals/api/get-started/create-token/).


**Note: when you setup a domain on cloudflare, it acts as a proxy by default.
This means it will both try to set up the certs for you and restrict ports
available on your server. We don't want cloudflare to do either. After you setup
the domain, ensure that "proxied" is toggled to off, and it says dns only.**

## Certs Renewal

This role utilizes certbot's own system for renewals.  Since we are issuing certs through 
the builtin plugin, we also benefit from automated renewals.  

The renewals are handled via systemd and a certbot timer.  On the server, you can see the list of systemd timers with:

``` sh
systemctl list-timers
```

and see the last time the renewal job was run with:

``` sh
systemctl status certbot
```

# Variables in this Role

| variable             | example                    | purpose                                                                                                                     |
|:---------------------|:---------------------------|:----------------------------------------------------------------------------------------------------------------------------|
| admin_username       | admin                      | who you log into the server as, instead of root.                                                                            |
| domain               | ansible.fun                | fqdn of host server. If prepended with `*.`, will create a wildcard cert. If var not provided, will use inventory hostname. |
| cloudflare_api_token | someApiString              | the zoned token created in cloudflare.                                                                                      |
| cert_email           | ops@planetary.social       | email used when assigning cert, for receiving notices (renewal,issues,etc)                                                  |
| homedir              | /home/{{ admin_username }} | the home directory of the current user                                                                                      |
 


