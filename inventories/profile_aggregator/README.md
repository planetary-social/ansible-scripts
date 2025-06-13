# Profile Aggregator Inventory

This inventory manages the deployment of the profile aggregator relay service.

## Hosts

- `relay.yestr.social` - Production profile aggregator relay

## Variables

### Required (in vault.yml)
- `profile_aggregator_secret_key` - The relay's secret key (production)
- `profile_aggregator_discovery_relay_url` - The relay URL to aggregate profiles from

### Optional
- `profile_aggregator_image_tag` - Docker image tag (default: latest)
- `profile_aggregator_log_level` - Rust log level configuration

## Usage

Deploy the profile aggregator:
```bash
ansible-playbook -i inventories/profile_aggregator/inventory.yml playbooks/profile_aggregator.yml --ask-vault-pass
```

## Vault Management

Encrypt secrets:
```bash
ansible-vault encrypt inventories/profile_aggregator/group_vars/all/vault.yml
```

Edit vault:
```bash
ansible-vault edit inventories/profile_aggregator/group_vars/all/vault.yml
```