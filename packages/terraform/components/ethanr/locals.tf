locals {
  resolved_hosted_zone_id = var.hosted_zone_id != "" ? var.hosted_zone_id : aws_route53_zone.main[0].zone_id

  # get package version from package.json
  package_version = jsondecode(file("${path.module}/../../package.json")).version
}
