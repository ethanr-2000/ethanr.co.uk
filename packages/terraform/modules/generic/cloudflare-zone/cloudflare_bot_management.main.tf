# Bot Fight Mode: challenges traffic Cloudflare is confident is automated
resource "cloudflare_bot_management" "main" {
  zone_id    = var.zone_id
  fight_mode = true
  enable_js  = true
}
