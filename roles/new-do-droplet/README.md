# new-do-droplets: Provision a new digital ocean droplet

This uses the digital ocean api to provision a new droplet with the provided variables.

To use this, you will need to be a part of Verse's organisation on
digitalocean.com, and have a [digital ocean api
token](https://docs.digitalocean.com/reference/api/create-personal-access-token/).

The role is intended to be run locally, since it's purpose is to create your new
remote host.

For an example of using this role, with its vars, see
playbooks/new-do-droplet.yml.

# Our opinionated provisioning

Our provisioned droplet will have some opinionated defaults, that are added
through a cloud-config file we pass along in the provisioning.

The primary opinion is that you should not log in as root, and only ssh login
should be allowed.

The other core opinion is to use github as the source of the ssh keys for this
user. The assumption is that if you are part of the digitalocean org, then you
are also a member of our github org.

Lastly, we do not store the digital ocean api token as a secret in this repo as
it is a personal access token. Instead, this role assumes the presence of an env
var named `DO_API_TOKEN` on your local system and uses its value for the role.


## Variables

|                     variable |                                                                 purpose |                                              default |
|-----------------------------:|------------------------------------------------------------------------:|-----------------------------------------------------:|
|              do_droplet_size |      ram/storage of droplet (see [do slugs](https://slugs.do-api.dev/)) |                                          s-1vcpu-1gb |
|            do_droplet_region |          datacenter location (see [do slugs](https://slugs.do-api.dev)) |                                                 SFO3 |
|             do_droplet_image |                                              iso image and architecture |                                     ubuntu-22-10-x64 |
| do_droplet_enable_monitoring |                                 whether to enable do's monitoring(free) |                                                 true |
|    do_droplet_enable_backups |                                whether to enable regular backups (paid) |                                                false |
|              do_droplet_name |                            often the domain of the service we're making | "{{do_droplet_image + '.' ansible_date_time.date }}" |
|           do_droplet_project |                                 The digital ocean project: Verse or Nos |                                                Verse |
|              do_droplet_tags |                                 a list of tags to attach to the droplet |                                                 none |
|          gh_user_keys_to_add | a list of github usernames for people who should have access to droplet |                                                 none |
|                 do_api_token |                  your api token. We pull this from env var DO_API_TOKEN |                                                 none |
|               admin_username |                                             the default user of server. |                                                admin |
