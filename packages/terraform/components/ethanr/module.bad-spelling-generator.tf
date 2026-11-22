# A static site: the page fetches its spelling data from data/ and does the rest itself
module "bad_spelling_generator" {
  source = "../../modules/generic/cloudflare-worker"

  account_id       = var.cloudflare_account_id
  zone_id          = var.cloudflare_zone_id
  hostname         = "bad-spelling-generator.${var.fqdn}"
  assets_directory = "${local.build_root}/ethanr.co.uk-bsg-site"

  # Not a single-page app: unknown paths get a 404 rather than a page whose relative
  # links (./index.js, ./data/...) resolve under the wrong path
  not_found_handling = "none"

  unique_ids = {
    local = "${local.unique_id}-bsg"
  }
}

# Keeps the existing Worker and custom domain rather than recreating them
moved {
  from = module.bad-spelling-generator.module.worker
  to   = module.bad_spelling_generator
}
