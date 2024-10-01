module planetary {
  source = "./planetary-resources"
}

module nos {
  source = "./nos-resources"

  # The Cloudflare account could technically be managed by Terraform, too.  However, doing so would require owner access
  # to the Cloudflare account which i don’t have, so let’s just store the account ID in a variable.
  cloudflare_account_id = "c84e7a9bf7ed99cb41b8e73566568c75"
}
