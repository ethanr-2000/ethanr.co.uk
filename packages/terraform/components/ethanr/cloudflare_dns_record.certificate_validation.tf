locals {
  # ACM validates the apex and its wildcard with the same CNAME, so the apex's record covers both
  certificate_validation = one([
    for dvo in aws_acm_certificate.main.domain_validation_options : dvo if dvo.domain_name == var.fqdn
  ])
}

resource "cloudflare_dns_record" "certificate_validation" {
  zone_id = var.cloudflare_zone_id
  name    = trimsuffix(local.certificate_validation.resource_record_name, ".")
  type    = local.certificate_validation.resource_record_type
  content = trimsuffix(local.certificate_validation.resource_record_value, ".")
  proxied = false
  ttl     = 1
  comment = "${local.unique_id}-acm"
}
