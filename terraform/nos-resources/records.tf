# id: eedecf4b04070b214585cb93a0bff546
resource cloudflare_zone nos_social {
  account_id = var.cloudflare_account_id
  zone       = "nos.social"
}

# id: 0e89e37481a6ece10908596241236628
resource cloudflare_record olympics_a {
  zone_id         = cloudflare_zone.nos_social.id
  name            = "olympics2024"
  type            = "A"
  content         = digitalocean_droplet.olympics2024_relay.ipv4_address
  allow_overwrite = true
}

# id: 6dc95cde49eb4808000f6251b3715c31
resource cloudflare_record olympics_wildcard {
  zone_id         = cloudflare_zone.nos_social.id
  name            = "*.olympics2024"
  type            = "A"
  content         = digitalocean_droplet.olympics2024_relay.ipv4_address
  allow_overwrite = true
}
