# nos-crossposting-service Inventory

This inventory is meant for deploying the nos-crossposting-service, whose code lives here:

https://github.com/planetary-social/nos-crossposting-service/actions

The inventory.yml holds all required variables for running the nos_crossposting_service playbook.

It holds two secret variables, for the twitter api key and secret, whose value is in `group_vars/all/vault.yml`

# Updating the service

The repo will create a new docker image for the service on each push to main, tagged `latest`.

The service on the server sets up a systemd job to regularly check for new images tagged `latest`.

For the most part, to update the service, you just need to push or merge to main.