# The domain is registered with Cloudflare Registrar, which publishes the DS record itself
resource "cloudflare_zone_dnssec" "main" {
  zone_id = var.zone_id
  status  = "active"
}
