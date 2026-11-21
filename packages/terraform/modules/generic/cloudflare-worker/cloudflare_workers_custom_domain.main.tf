# Creates the hostname's DNS record and certificate. The hostname must not already
# have its own A, AAAA or CNAME record
resource "cloudflare_workers_custom_domain" "main" {
  count = var.hostname != null ? 1 : 0

  account_id = var.account_id
  zone_id    = var.zone_id
  hostname   = var.hostname
  service    = cloudflare_workers_script.main.script_name
}
