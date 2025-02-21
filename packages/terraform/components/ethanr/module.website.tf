module "website" {
  source = "../../modules/project/website"

  aws = local.aws

  acm_certificate_arn = aws_acm_certificate.main.arn
  hosted_zone_id      = local.resolved_hosted_zone_id
  fqdn                = var.fqdn
  s3_path             = "website"
  s3_bucket_name      = aws_s3_bucket.assets.bucket
  s3_bucket_regional_domain_name = aws_s3_bucket.assets.bucket_regional_domain_name
  s3_bucket_arn       = aws_s3_bucket.assets.arn
  package_version     = local.package_version

  module_parents = []

  unique_ids = {
    local   = "${local.unique_id}-website"
    account = "${local.unique_id_account}-website"
    global  = "${local.unique_id_global}-website"
  }
}
