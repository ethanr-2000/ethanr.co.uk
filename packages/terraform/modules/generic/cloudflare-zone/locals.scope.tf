locals {
  unique_id = var.unique_ids["local"]

  zone_name = data.cloudflare_zone.main.name
}
