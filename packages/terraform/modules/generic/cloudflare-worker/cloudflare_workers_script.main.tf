resource "cloudflare_workers_script" "main" {
  account_id         = var.account_id
  script_name        = local.name
  compatibility_date = var.compatibility_date

  main_module    = local.has_script ? basename(var.script_path) : null
  content_file   = local.has_script ? var.script_path : null
  content_sha256 = local.has_script ? filesha256(var.script_path) : null

  # Files that match a request are served without running the script
  assets = local.has_assets ? {
    directory = var.assets_directory
    config = {
      not_found_handling = local.has_script ? null : var.not_found_handling
      headers            = var.asset_headers
    }
  } : null

  bindings = length(local.bindings) > 0 ? local.bindings : null

  observability = {
    enabled = var.logs_enabled
  }

  lifecycle {
    precondition {
      condition     = local.has_script || local.has_assets
      error_message = "Set script_path, assets_directory or both."
    }
  }
}
