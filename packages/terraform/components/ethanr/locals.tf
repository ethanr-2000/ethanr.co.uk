locals {
  resolved_hosted_zone_id = var.hosted_zone_id != "" ? var.hosted_zone_id : aws_route53_zone.main[0].zone_id
}