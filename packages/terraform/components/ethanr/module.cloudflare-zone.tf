module "cloudflare_zone" {
  source = "../../modules/generic/cloudflare-zone"
  count  = var.manage_dns_zone ? 1 : 0

  zone_id = var.cloudflare_zone_id

  unique_ids = {
    local = "${local.unique_id}-zone"
  }
}
