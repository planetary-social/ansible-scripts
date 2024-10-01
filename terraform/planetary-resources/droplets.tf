resource digitalocean_droplet pub-one {
  name              = "pub-one"
  image             = "69440042"
  size              = "s-2vcpu-4gb"
  backups           = false
  monitoring        = false
  graceful_shutdown = false
  tags              = ["pub"]
}

resource digitalocean_droplet pub-two {
  name              = "pub-two"
  image             = "69440042"
  size              = "s-2vcpu-4gb"
  backups           = false
  monitoring        = false
  graceful_shutdown = false
  tags              = ["pub"]
}

resource digitalocean_droplet room-server {
  name              = "room.planetary.name"
  image             = "84780478"
  size              = "s-1vcpu-1gb"
  backups           = true
  monitoring        = false
  graceful_shutdown = false
  tags              = []
}

resource digitalocean_droplet name-server {
  name              = "planetary.name"
  image             = "112929408"
  size              = "s-2vcpu-4gb"
  backups           = true
  monitoring        = true
  graceful_shutdown = false
  tags              = []
}

resource digitalocean_droplet graphql {
  name              = "planetary-graphql"
  image             = "112929408"
  size              = "s-1vcpu-2gb"
  backups           = false
  monitoring        = true
  graceful_shutdown = false
  tags              = ["graphql", "pub"]
}
