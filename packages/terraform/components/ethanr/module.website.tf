module "website" {
  source = "../../modules/generic/cloudflare-worker"

  account_id       = var.cloudflare_account_id
  zone_id          = var.cloudflare_zone_id
  hostname         = var.fqdn
  assets_directory = "${local.build_root}/ethanr.co.uk-website"

  unique_ids = {
    local = "${local.unique_id}-website"
  }
}
