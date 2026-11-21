# A Worker with only static assets. Without a script, paths that match no file are
# served index.html, so client-side routes work
resource "cloudflare_workers_script" "main" {
  account_id         = var.cloudflare_account_id
  script_name        = local.unique_id
  compatibility_date = "2026-11-01"

  assets = {
    directory = local.asset_root
    config = {
      not_found_handling = "single-page-application"
    }
  }
}
