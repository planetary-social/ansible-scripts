An example inventory to show and test variable behaviour using the group_vars
directory.

Ansible's built-in behaviour when running an inventory is to look for a
`group_vars`dir and a `host_vars`dir. If found, it will use these variables in
the topmost level, and then look for any directories named after a child group
and recurse through these. Variables in the child dirs will take precedence over the
same variable defined in the parent dir.

## Context
In this inventory, we have two servers, both named as hosts and so both under the `all`
group.  One server, ansible.fun, is in the`lab` group while the other,
`dev-notifications.nostr.social` is in the `nostr` group.  These group names are arbitrary,
to show they can be whatever key you define.

In the same directory as this inventory is our `group_vars`, which has this structure:

```
group_vars
├── all
│   ├── vars.yml
│   └── vault.yml
├── lab
│   ├── vars.yml
│   └── vault.yml
└── nostr
    ├── vars.yml
    └── vault.yml
```

in each dir, `vars.yml` list the variables we set, while `vault.yml` contains our encrypted secrets.
If a variable should be a secret, we define it in the `vars.yml` like so:

``` yaml
admin_password: "{{ vault_admin_password }}"
```
And then `vault_admin_password` is defined in vault.yml.

You can see the secret file with this invocation:

```
ansible-vault show inventories/vars-example/all/vault.yml
```
(the password for all these example files is `demo`)

The intention in this struct is so you can understand the variables that will be
used without having to decrypt any files (and then have to remember to
re-encrypt them before committing). The only time you need to decrypt is if you are
changing the secret var.

## Running the example

Assuming you have access to both servers in the inventory.yml file, you can run
the playbook from the root of the repo like so:

```
ansible-playbook --ask-vault-pass -i inventories/vars-example/inventory.yml vars-example-playbook.yml
```


The playbook loops through some vars and prints them as debug statements, returning:

```
ok: [ansible.fun] => (item=listen_port) => {
    "ansible_loop_var": "item",
    "item": "listen_port",
    "listen_port": 8008
}
ok: [ansible.fun] => (item=app_image) => {
    "ansible_loop_var": "item",
    "app_image": "ghcr.io/planetary/example-image",
    "item": "app_image"
}
ok: [ansible.fun] => (item=app_image_tag) => {
    "ansible_loop_var": "item",
    "app_image_tag": "stable",
    "item": "app_image_tag"
}
ok: [ansible.fun] => (item=admin_password) => {
    "admin_password": "this_is_the_lab_password",
    "ansible_loop_var": "item",
    "item": "admin_password"
}
ok: [ansible.fun] => (item=app_environment) => {
    "ansible_loop_var": "item",
    "app_environment": "LAB",
    "item": "app_environment"
}
ok: [dev-notifications.nos.social] => (item=listen_port) => {
    "ansible_loop_var": "item",
    "item": "listen_port",
    "listen_port": 8008
}
ok: [dev-notifications.nos.social] => (item=app_image) => {
    "ansible_loop_var": "item",
    "app_image": "ghcr.io/planetary/example-image",
    "item": "app_image"
}
ok: [dev-notifications.nos.social] => (item=app_image_tag) => {
    "ansible_loop_var": "item",
    "app_image_tag": "latest",
    "item": "app_image_tag"
}
ok: [dev-notifications.nos.social] => (item=admin_password) => {
    "admin_password": "the_default_admin_password",
    "ansible_loop_var": "item",
    "item": "admin_password"
}
ok: [dev-notifications.nos.social] => (item=app_environment) => {
    "ansible_loop_var": "item",
    "app_environment": "NOSTR",
    "item": "app_environment"
}
```

## What happened?

When the inventory was run, it applied the variables defined in the `all` dir,
including one called `admin_password`. Both `group_vars/lab` and
`group_vars/nostr` defined variables for the image tag and the app environment,
while `group_vars/lab`also assigned a new value to `admin_password`.

We can see the vars defined in the `group_vars` directory were picked up by
ansible and ansible respected our expected precedence. Both servers share the variables for
the listen port and the app image, while having different app environments and
image tags. the `nostr`host inherited the password defined in
`group_vars/all`(since it didn't define anyything new) while our `lab`host uses
the password defined in its directory.
