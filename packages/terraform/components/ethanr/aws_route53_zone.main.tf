resource "aws_route53_zone" "main" {
  name = var.fqdn

  tags = local.default_tags
}