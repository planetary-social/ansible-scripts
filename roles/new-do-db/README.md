# New DigitalOcean DB Role

This role sets up a digital ocean managed database using the ansible digitalocean community module.

It is similar to our new-do-droplet role, and likely will be used in close tandem.


## Variables

| Variable           | Description                                                                 | Example          |
|:------------------:|:---------------------------------------------------------------------------:|:----------------:|
| do_oauth_token     | digital ocean api token with permissions for creating db's                  | do_52dthajdj     |
| do_db_engine       | which database to use. Can be one of: "pg" "mysql" "redis" "mongodb"        | "pg"             |
| do_db_size         | slug identifier for size of db node see note below                          | db-amd-1vcpu-1gb |
| do_db_num_nodes    | how many cluster nodes for db                                               | 1                |
| do_droplet_project | digitalocean project to organize db under. Same as droplet if made together | Nos              |
| do_droplet_region  | datacenter region for db cluster node. Same as droplet if made together     | NYC              |
| do_droplet_tags    | Any tags for organizing withing digitalocean ui                             | dev              |
|                    |                                                                             |                  |

## On do_db_size

You will need to give a slug for this, and the slug is dependent on the engine you are using.

You can get a list of available sizes and their slugs using the doctl command, e.g.:

``` sh
doctl databases options slugs --engine pg
```