module "bad-spelling-generator" {
  source = "../../modules/project/bad-spelling-generator"

  aws = local.aws

  acm_certificate_arn = aws_acm_certificate.main.arn
  hosted_zone_id      = local.resolved_hosted_zone_id
  fqdn                = "bad-spelling-generator.${var.fqdn}"
  s3_path             = "bsg"
  s3_bucket_name      = aws_s3_bucket.assets.bucket
  s3_bucket_regional_domain_name = aws_s3_bucket.assets.bucket_regional_domain_name
  s3_bucket_arn       = aws_s3_bucket.assets.arn
  package_version     = local.package_version

  module_parents = []

  unique_ids = {
    local   = "${local.unique_id}-bsg"
    account = "${local.unique_id_account}-bsg"
    global  = "${local.unique_id_global}-bsg"
  }
}
