module "mario_kart_tournament_scheduler" {
  source = "../../modules/project/mario-kart-tournament-scheduler"

  aws = local.aws

  acm_certificate_arn            = aws_acm_certificate.main.arn
  hosted_zone_id                 = local.resolved_hosted_zone_id
  fqdn                           = "mario-kart-tournament-scheduler.${var.fqdn}"
  s3_path                        = "mkts"
  s3_bucket_name                 = aws_s3_bucket.assets.bucket
  s3_bucket_regional_domain_name = aws_s3_bucket.assets.bucket_regional_domain_name
  s3_bucket_arn                  = aws_s3_bucket.assets.arn
  package_version                = local.package_version

  module_parents = []

  unique_ids = {
    local   = "${local.unique_id}-mkts"
    account = "${local.unique_id_account}-mkts"
    global  = "${local.unique_id_global}-mkts"
  }
}
