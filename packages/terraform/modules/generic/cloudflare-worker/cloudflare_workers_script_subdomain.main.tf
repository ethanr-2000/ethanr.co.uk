# Only reachable on its custom domain, not <name>.<account>.workers.dev or preview URLs
resource "cloudflare_workers_script_subdomain" "main" {
  account_id       = var.account_id
  script_name      = cloudflare_workers_script.main.script_name
  enabled          = false
  previews_enabled = false
}
