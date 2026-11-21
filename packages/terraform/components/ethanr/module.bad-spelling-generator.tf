module "bad-spelling-generator" {
  source = "../../modules/project/bad-spelling-generator"

  aws = local.aws

  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_zone_id    = var.cloudflare_zone_id
  fqdn                  = "bad-spelling-generator.${var.fqdn}"

  module_parents = []

  unique_ids = {
    local   = "${local.unique_id}-bsg"
    account = "${local.unique_id_account}-bsg"
    global  = "${local.unique_id_global}-bsg"
  }
}
