module "mario_kart_tournament_scheduler" {
  source = "../../modules/generic/cloudflare-worker"

  account_id       = var.cloudflare_account_id
  zone_id          = var.cloudflare_zone_id
  hostname         = "mario-kart-tournament-scheduler.${var.fqdn}"
  assets_directory = "${local.build_root}/ethanr.co.uk-mkts"

  unique_ids = {
    local = "${local.unique_id}-mkts"
  }
}
