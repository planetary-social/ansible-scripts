# Profile Aggregator Ansible Role

This role deploys the profile aggregator relay service.

## Requirements

- Docker and Docker Compose (installed via docker role dependency)
- Traefik (installed via traefik role dependency)
- Valid domain name with DNS pointing to server

## Role Variables

See `defaults/main.yml` for all available variables.

Key variables:
- `profile_aggregator_image`: Docker image to use
- `profile_aggregator_image_tag`: Image tag (default: latest)
- `profile_aggregator_discovery_relay_url`: Relay to aggregate profiles from
- `profile_aggregator_secret_key`: Relay's secret key (should be in vault)

## Dependencies

- common
- digital-ocean
- docker
- traefik

## Example Playbook

```yaml
- hosts: profile_aggregator
  roles:
    - profile_aggregator
```