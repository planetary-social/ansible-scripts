# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This repository contains Ansible automation scripts for Planetary.social infrastructure. It uses a standard Ansible structure with playbooks, inventories, and roles to manage various services including Nostr relays, notification services, RSS feeds, and more.

## Common Development Commands

### Running Playbooks
```bash
# Run a playbook against an inventory
ansible-playbook -i inventories/<inventory_name>/inventory.yml playbooks/<playbook_name>.yml

# Run with vault password (required for encrypted variables)
ansible-playbook -i inventories/<inventory_name>/inventory.yml playbooks/<playbook_name>.yml --ask-vault-pass

# Dry run (check mode - no changes made)
ansible-playbook -i inventories/<inventory_name>/inventory.yml playbooks/<playbook_name>.yml --check

# Run with verbose output
ansible-playbook -i inventories/<inventory_name>/inventory.yml playbooks/<playbook_name>.yml -v

# Syntax check a playbook
ansible-playbook playbooks/<playbook_name>.yml --syntax-check
```

### Managing Vault Files
```bash
# Edit vault file (requires .vault_pass file or --ask-vault-pass)
ansible-vault edit inventories/<inventory_name>/group_vars/all/vault.yml

# View vault file contents
ansible-vault view inventories/<inventory_name>/group_vars/all/vault.yml

# Encrypt a file
ansible-vault encrypt <file>

# Decrypt a file
ansible-vault decrypt <file>
```

### Installing Dependencies
```bash
# Install required Ansible Galaxy collections
ansible-galaxy install -r requirements.yml
```

### Creating New Components (with Nix/direnv)
```bash
# Create a new role
new-role <role_name>

# Create a new inventory
new-inventory <inventory_name>
```

## Architecture and Structure

### Directory Layout
- **playbooks/**: Ansible playbooks that orchestrate role execution against inventories
- **inventories/**: Server inventories with group variables (including encrypted vault files)
- **roles/**: Reusable Ansible roles containing tasks, templates, files, and defaults

### Key Patterns

1. **Inventory-Playbook Pairing**: Most playbooks match inventory names (e.g., `playbooks/profile_aggregator.yml` runs against `inventories/profile_aggregator/`)

2. **Variable Hierarchy**:
   - Group variables in `inventories/<name>/group_vars/`
   - Environment-specific vars in subgroups (e.g., `dev/`, `prod/`)
   - Secrets encrypted in `vault.yml` files
   - User-specific vars passed via environment variables (e.g., `CLOUDFLARE_API_TOKEN`, `DO_API_TOKEN`)

3. **Service Deployment Pattern**:
   - Most services use Docker Compose deployments
   - Templates in `roles/<role>/templates/` generate docker-compose.yml files
   - Services typically deployed to `~/services/<service_name>/` on target hosts
   - Health checks and image updates configured via included roles

4. **Common Role Dependencies**:
   - `docker`: Installs Docker on target hosts
   - `node-exporter`: Adds monitoring to servers
   - `certbot-cloudflare`: SSL certificate management
   - `image-update-service`: Automated Docker image updates
   - `health-check`: Service health monitoring

5. **Firewall Configuration**:
   - UFW rules configured per service
   - Cloudflare IP allowlisting when `all_domains_proxied_through_cloudflare` is true
   - VPC peering support for internal communication

## Environment Requirements

- Ansible vault password file at `./.vault_pass` (or use `--ask-vault-pass`)
- Environment variables for external services:
  - `DO_API_TOKEN`: DigitalOcean API access
  - `CLOUDFLARE_API_TOKEN`: Cloudflare DNS management
- SSH access to target hosts (managed via ssh-config-and-harden role)

## Nix Development Environment

When using Nix with direnv:
- Automatically loads required tools (ansible, doctl, netcat, tree)
- Provides scaffolding commands (`new-role`, `new-inventory`)
- Environment variables loaded from `.envrc`