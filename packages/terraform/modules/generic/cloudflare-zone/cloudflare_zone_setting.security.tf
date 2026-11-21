locals {
  security_settings = {
    always_use_https         = "on"
    automatic_https_rewrites = "on"
    min_tls_version          = "1.2"
    tls_1_3                  = "on"
    ssl                      = "strict" # Only matters for proxied records with an origin, not Workers
  }
}

resource "cloudflare_zone_setting" "security" {
  for_each = local.security_settings

  zone_id    = var.zone_id
  setting_id = each.key
  value      = each.value
}

# HSTS for a year on every hostname in the zone. Browsers remember it, so every
# subdomain must keep serving HTTPS
resource "cloudflare_zone_setting" "hsts" {
  zone_id    = var.zone_id
  setting_id = "security_header"
  value = {
    strict_transport_security = {
      enabled            = true
      max_age            = 31536000
      include_subdomains = true
      preload            = false
      nosniff            = true
    }
  }
}
