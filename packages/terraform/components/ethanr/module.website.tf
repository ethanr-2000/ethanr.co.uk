module "website" {
  source = "../../modules/project/website"

  aws = local.aws

  fqdn                = var.fqdn
  hosted_zone_id      = aws_route53_zone.main.zone_id
  ssl_certificate_arn = aws_acm_certificate.main.arn
  # ssl_certificate_arn = ""
  
  package_version = var.package_version

  module_parents = []

  unique_ids = {
    local   = "${local.unique_id}-website"
    account = "${local.unique_id_account}-website"
    global  = "${local.unique_id_global}-website"
  }
}
