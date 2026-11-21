module "website" {
  source = "../../modules/project/website"

  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_zone_id    = var.cloudflare_zone_id
  fqdn                  = var.fqdn

  unique_ids = {
    local = "${local.unique_id}-website"
  }
}
