The Sentry role configures a digital ocean droplet with a running instances of the [Sentry error tracking software](https://sentry.io). Sentry is mainly used to gather crash reports from our iOS app.

## Variables

| variable                   | purpose                                               |
|----------------------------|-------------------------------------------------------|
| vault_cloudflare_api_token | Access Cloudflare API for cert renewals               |
| vault_sentry_secret_key    | Allowing clients to communicate securely with Sentry  |
| vault_slack_client_id      | Allowing Sentry to post to Slack                      |
| vault_slack_client_secret  | Allowing Sentry to post to Slack                      |
| vault_slack_signing_secret | Allowing Sentry to post to Slack                      |
| vault_google_client_id     | Supporting authentication via Google                  |
| vault_google_client_secret | Supporting authentication via Google                  |
