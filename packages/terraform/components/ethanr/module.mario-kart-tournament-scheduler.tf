module "mario_kart_tournament_scheduler" {
  source = "../../modules/project/mario-kart-tournament-scheduler"

  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_zone_id    = var.cloudflare_zone_id
  fqdn                  = "mario-kart-tournament-scheduler.${var.fqdn}"

  unique_ids = {
    local = "${local.unique_id}-mkts"
  }
}
