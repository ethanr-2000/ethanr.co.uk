resource "aws_route53_zone" "main" {
  count = var.hosted_zone_id == "" ? 1 : 0

  name = var.fqdn

  tags = local.default_tags
}