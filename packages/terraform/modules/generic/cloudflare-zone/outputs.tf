output "dnssec_status" {
  value = cloudflare_zone_dnssec.main.status
}
