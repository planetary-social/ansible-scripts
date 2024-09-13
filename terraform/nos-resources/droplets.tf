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
