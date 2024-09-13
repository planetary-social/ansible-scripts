# Planetary Ansible Scripts

This repository contains the [ansible](https://www.ansible.com/) automation
scripts we use to set up some of our infrastructure at Planetary.social. These
scripts are not designed to be used outside of Planetary, but are still
published here in case they are useful for other scuttlebutt/nostr users.

# Setup

1. Install Ansible and Ansible Galaxy
2. Run `ansible-galaxy install -r requirements.yml`

# Repo structure

Ansible is structured around running playbooks against an inventory of servers.  Our repo is mainly structured, around our
`playbooks`directory and our `inventories` directory.

Most playbooks and inventories share names.  `playbook/rss.yml` is designed to run against our `rss` servers which are held in
`inventories/rss`.

## The inventories directory
Our inventories are designed around different groups each with their own
variables, held in source control. The simplest way we found to do this is to
hold the variables in a `group_vars` directory that is in the same dir as the
inventory file being called.

For example: for our notification service, all our servers are in the
`notifications` group, while a subset of them are in the`prod` group and others
in `dev`. Its inventory dir, then, is structured like so:

```
inventories/notifications_service
├── group_vars
│   ├── all
│   │   └── vault.yml
│   ├── dev
│   │   └── vault.yml
│   └── prod
│       └── vault.yml
├── inventory.yml
└── README.md
```

This lets us have different variables or secrets for dev/production or any other grouping we need.

Any secret variables are encrypted in the `vault.yml` file. If you need to use
these ansible roles, then you should have the vault decryption key.

## Group vars versus user vars

For the most part, any variables needed for a script are defined in the
inventory file itself. There are some variables that are passed in through env
vars instead. These variables are user specific and should not be shared among
us: e.g. your personal cloudflare api token. You will want to make sure you have
these set as env vars. This can be made simple with direnv, and our built-in
nix/direnv support.

# Using nix with our scripts

This repo is built to work with nix and direnv. Specifically, it sets up a
customized devshell with some scaffoldihng commands and easy env var support.

To use this, you will want to [install direnv](https://direnv.net/), [install
nix](https://nixos.org/download#download-nix), and then [enable flake
support](https://nixos.wiki/wiki/Flakes#Enable_flakes).

Then, in this repo, add a .envrc. It should be structured like so(note `use
flake .` in first line):

For example:

``` sh
use flake .
export SOME_VAR=ooohsecret
export SOME_OTHER_VAR=coolio
```

Now, when you enter the repository, direnv will put you straight into the nix
dev shell, with ansible and other commands installed. This may take a moment hte
first time, but is quick all subsequent times.

# Making new roles or inventories

If you are using nix and direnv, you can scaffold out new inventories or new
roles with the commands `new-inventory $inventoryname` and `new-role $rolename`

# Terraform

Infrastructure building blocks are managed by Terraform.

For now you will need to install Terraform manually from the [Terraform
site](https://developer.hashicorp.com/terraform/install).

Terraform state is NOT stored in this repository as it may contain secret keys and passwords in plain text.

To access the Terraform state, you will need access to the Digitalocean Spaces bucket `nos-social-infra-state`.  To
apply configuration changes, you will also need the following environment variables ready:

- `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` must be set to a valid Spaces key pair. Obtain it from the
  [DigitalOcean dashboard](https://cloud.digitalocean.com/account/api/spaces?i=803615)
- `DIGITALOCEAN_ACCESS_TOKEN` must be set to a valid DigitalOcean personal access token. Obtain it
  [here](https://cloud.digitalocean.com/account/api/tokens/new?i=803615).  Setting scopes to Full Access is recommended
  for now.
- `CLOUDFLARE_API_TOKEN` must be set to a valid CloudFlare API token.  Obtain it
  [here](https://dash.cloudflare.com/profile/api-tokens). Use the template Edit zone DNS for easier setup.

To check if Terraform is working as expected:

```
cd terraform
terraform plan
```

If you modify Terraform files and want to make it the new reality, use

```
terraform apply
```
