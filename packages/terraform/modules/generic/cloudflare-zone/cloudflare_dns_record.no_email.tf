# The domain neither sends nor receives email.
# These records tell this to the world.

resource "cloudflare_dns_record" "null_mx" {
  zone_id  = var.zone_id
  name     = local.zone_name
  type     = "MX"
  content  = "."
  priority = 0
  ttl      = 1
  comment  = local.unique_id
}

resource "cloudflare_dns_record" "spf" {
  zone_id = var.zone_id
  name    = local.zone_name
  type    = "TXT"
  content = "\"v=spf1 -all\""
  ttl     = 1
  comment = local.unique_id
}

resource "cloudflare_dns_record" "dmarc" {
  zone_id = var.zone_id
  name    = "_dmarc.${local.zone_name}"
  type    = "TXT"
  content = "\"v=DMARC1; p=reject; sp=reject; adkim=s; aspf=s\""
  ttl     = 1
  comment = local.unique_id
}
