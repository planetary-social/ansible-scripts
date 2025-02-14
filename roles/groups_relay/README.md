# groups_relay role

This role sets up a Nostr groups relay server using strfry as the backend relay. It's designed to handle NIP-29 group messages.

## Architecture

The role deploys two main services:
1. `groups_relay` - A specialized relay that handles NIP-29 group messages
2. `strfry` - A lightweight Nostr relay that serves as the backend storage

## Variables

| Variable                     | Example                                    | Purpose                                    |
|-----------------------------|--------------------------------------------|--------------------------------------------|
| domain                      | communities.nos.social                      | The FQDN of the service                    |
| cert_email                  | ops@planetary.social                        | The email used for LetsEncrypt certificate |
| groups_relay_image          | ghcr.io/verse-pbc/groups_relay             | The Docker image name                      |
| groups_relay_image_tag      | stable                                     | The Docker image tag                       |
| groups_relay_health_endpoint| https://{{ inventory_hostname }}/health    | Health check endpoint                      |

## Dependencies

The role depends on:
- common
- digital-ocean
- docker
- traefik

## Network Configuration

The service exposes the groups relay on port 8080 through Traefik, while strfry runs internally and is not exposed to the internet. All traffic is routed through the `proxy` network managed by Traefik.
