# Planetary Ansible Scripts

This repository contains the [ansible](https://www.ansible.com/) automation scripts we use to set up some of our infrastructure at Planetary.social. These scripts are not designed to be used outside of Planetary, but are still published here in case they are useful for other scuttlebutt users.

In particular, this repository contains scripts to automate the deployment of `ssb-server`. The playbook for pubs is `pubs.yml`, and can be executed with a command like `ansible-playbook -i your_inventory.yml pubs.yml`.
