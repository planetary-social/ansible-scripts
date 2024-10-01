# RELAYS

resource digitalocean_droplet main_relay {
  name              = "relay.nos.social"
  size              = "s-4vcpu-8gb"
  image             = "164762275"
  region            = "nyc3"
  monitoring        = true
  backups           = true
  tags              = ["prod"]
  graceful_shutdown = false
}

resource digitalocean_droplet olympics2024_relay {
  name              = "olympics2024.nos.social"
  size              = "s-1vcpu-1gb"
  image             = "ubuntu-24-04-x64"
  region            = "nyc3"
  monitoring        = true
  backups           = true
  tags              = ["development"]
  graceful_shutdown = false
}

resource digitalocean_droplet dwebcamp_relay {
  name              = "dwebcamp.nos.social"
  size              = "s-2vcpu-2gb-intel"
  image             = "ubuntu-22-04-x64"
  region            = "nyc3"
  monitoring        = true
  backups           = true
  tags              = []
  graceful_shutdown = false
}

resource digitalocean_droplet news_relay {
  name              = "news.nos.social"
  size              = "s-1vcpu-1gb"
  image             = "ubuntu-22-04-x64"
  region            = "nyc3"
  monitoring        = true
  backups           = true
  tags              = ["development"]
  graceful_shutdown = false
}

# Services

resource digitalocean_droplet followers {
  name              = "followers.nos.social"
  size              = "s-2vcpu-4gb"
  image             = "ubuntu-24-04-x64"
  region            = "nyc3"
  monitoring        = true
  backups           = true
  tags              = ["development"]
  graceful_shutdown = false
}

resource digitalocean_droplet reportinator2 {
  name              = "reportinator2.ansible.fun"
  size              = "s-1vcpu-1gb"
  image             = "129211873"
  region            = "nyc3"
  monitoring        = true
  backups           = true
  tags              = ["dev"]
  graceful_shutdown = false
}

resource digitalocean_droplet rsslay {
  name              = "rss.nos.social"
  size              = "s-1vcpu-2gb"
  image             = "129211873"
  region            = "nyc3"
  monitoring        = true
  backups           = true
  tags              = ["prod"]
  graceful_shutdown = false
}

resource digitalocean_droplet connect {
  name              = "connect.nos.social"
  size              = "s-1vcpu-1gb"
  image             = "129211873"
  region            = "nyc3"
  monitoring        = true
  backups           = true
  tags              = ["prod"]
  graceful_shutdown = false
}

resource digitalocean_droplet events {
  name              = "events.nos.social"
  size              = "s-2vcpu-2gb"
  image             = "129211873"
  region            = "nyc3"
  monitoring        = true
  backups           = true
  tags              = ["prod"]
  graceful_shutdown = false
}

resource digitalocean_droplet notifications {
  name              = "notifications.nos.social"
  size              = "s-1vcpu-1gb"
  image             = "129211873"
  region            = "nyc3"
  monitoring        = true
  backups           = true
  tags              = ["prod"]
  graceful_shutdown = false
}

# Development servers

resource digitalocean_droplet dev_notifications {
  name              = "dev-notifications.nos.social"
  size              = "s-1vcpu-1gb"
  image             = "129211873"
  region            = "nyc3"
  monitoring        = true
  backups           = true
  tags              = ["dev"]
  graceful_shutdown = false
}
resource digitalocean_droplet dev_metrics {
  name              = "metrics.ansible.fun"
  size              = "s-1vcpu-1gb"
  image             = "119383150"
  region            = "sfo3"
  monitoring        = true
  backups           = true
  tags              = ["dev"]
  graceful_shutdown = false
}


# Everything else

resource digitalocean_droplet metrics {
  name              = "metrics"
  size              = "s-2vcpu-4gb"
  image             = "119383150"
  region            = "nyc1"
  monitoring        = true
  backups           = true
  tags              = ["grafana", "prometheus"]
  graceful_shutdown = false
}

resource digitalocean_droplet sentry {
  name              = "sentry.io"
  size              = "s-4vcpu-16gb-amd"
  image             = "129211873"
  region            = "nyc3"
  monitoring        = true
  backups           = true
  tags              = []
  graceful_shutdown = false
}

resource digitalocean_droplet nos_social {
  name              = "nos.social"
  size              = "s-2vcpu-8gb-160gb-intel"
  image             = "129211873"
  region            = "nyc3"
  monitoring        = true
  backups           = true
  tags              = ["new", "prod"]
  graceful_shutdown = false
}
