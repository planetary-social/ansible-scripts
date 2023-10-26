# nostrface


This role sets up an existing digitalocean server with our [nostrface service](https://github.com/planetary-social/nostrface).

It first runs through our basic server setup roles (see meta/main for the role dependencies), then runs the service as a docker image with a systemd service set to continually poll our container registry for new version of the image.  This lets us update the image and have it reflected in our services without having to do any additional deployment steps.

## Variables

| variable                           | example                            | purpose                          |
|------------------------------------|------------------------------------|----------------------------------|
| domain                             | nosface.ansible.fun                | the http domain for this service |
| nostrface_image                    | ghcr.io/planetary-social/nostrface | which docker image to run        |
| nostrface_image_tag                | stable                             | Which docker image tag to use    |
| notifications_nostr_listen_address | 3000                               | the port the service listens on  |
