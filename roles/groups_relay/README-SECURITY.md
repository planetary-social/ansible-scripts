# Groups Relay Security Configuration

## Single Variable Configuration

The `all_domains_proxied_through_cloudflare` variable controls both firewall rules and header trust settings.

### Option 1: Cloudflare Only Mode (`all_domains_proxied_through_cloudflare: true`)
For relays where ALL domains and subdomains are proxied through Cloudflare (e.g., hol.is).

**Host Variables:**
```yaml
# inventories/groups_relay/host_vars/hol.is/main.yml
all_domains_proxied_through_cloudflare: true
```

**What happens:**
- Firewall blocks all non-Cloudflare IPs
- Traefik trusts forwarded headers (safe because only CF can connect)

**Result:**
- ✅ Real client IPs in logs
- ✅ No one can fake X-Forwarded-For headers
- ✅ Full DDoS protection
- ❌ Cannot access non-proxied subdomains

### Option 2: Mixed Mode (`all_domains_proxied_through_cloudflare: false`) - Default
For relays with some direct-access subdomains (e.g., communities.nos.social, communities2.nos.social).

**Host Variables:**
```yaml
# inventories/groups_relay/host_vars/communities2.nos.social/main.yml
all_domains_proxied_through_cloudflare: false  # or just omit it (default)
```

**What happens:**
- Firewall allows direct access for non-proxied subdomains
- Traefik doesn't trust forwarded headers (secure since anyone can connect)

**Result:**
- ❌ Cloudflare IPs in logs (not real client IPs)
- ✅ Secure - headers cannot be faked
- ✅ Subdomains work without Cloudflare
- ⚠️  Less DDoS protection on subdomains

## Summary

One variable controls everything:
- `all_domains_proxied_through_cloudflare: true` = Strict mode (CF only, real IPs)
- `all_domains_proxied_through_cloudflare: false` = Compatible mode (mixed access, CF IPs only)