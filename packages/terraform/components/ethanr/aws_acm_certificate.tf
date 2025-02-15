resource "aws_acm_certificate" "main" {
  provider = aws.us-east-1

  domain_name       = var.fqdn
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.fqdn}"
  ]

  tags = local.default_tags
}