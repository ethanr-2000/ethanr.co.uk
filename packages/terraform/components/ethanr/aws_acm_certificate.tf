resource "aws_acm_certificate" "main" {
  provider = aws.us-east-1

  domain_name       = var.fqdn
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.fqdn}"
  ]

  tags = local.default_tags

  # CloudFront still uses the old certificate until the new one replaces it
  lifecycle {
    create_before_destroy = true
  }
}
