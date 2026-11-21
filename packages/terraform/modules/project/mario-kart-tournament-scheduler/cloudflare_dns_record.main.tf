# DNS only, not proxied, while the site is still served by CloudFront
resource "cloudflare_dns_record" "main" {
  zone_id = var.cloudflare_zone_id
  name    = var.fqdn
  type    = "CNAME"
  content = aws_cloudfront_distribution.main.domain_name
  proxied = false
  ttl     = 1
  comment = local.unique_id
}
