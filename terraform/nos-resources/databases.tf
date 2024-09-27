resource digitalocean_database_cluster nos_social_prod {
  name       = "nos-social-prod"
  node_count = 1
  size       = "db-s-1vcpu-1gb"
  region     = "nyc3"
  engine     = "redis"
  version    = "7"
  tags       = ["prod"]
}
