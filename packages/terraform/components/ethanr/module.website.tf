module "website" {
  source = "../../modules/project/website"

  aws = local.aws

  fqdn            = "ethanr.co.uk"
  package_version = var.package_version

  module_parents = []

  unique_ids = {
    local   = "${local.unique_id}-website"
    account = "${local.unique_id_account}-website"
    global  = "${local.unique_id_global}-website"
  }
}
