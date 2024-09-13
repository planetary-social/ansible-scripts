terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = ">= 2.34.1"
    }
    cloudflare = {
      source = "cloudflare/cloudflare"
      version = "~> 4"
    }
  }

  backend "s3" {
    bucket                      = "nos-social-infra-state"
    key                         = "infra.tfstate"
    region                      = "nyc3"
    endpoints                   = {
      s3 = "https://nyc3.digitaloceanspaces.com"
    }
    use_path_style              = true
    skip_credentials_validation = true
    skip_region_validation      = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
