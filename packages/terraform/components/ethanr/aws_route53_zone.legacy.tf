# ethanr.uk is being left to lapse on 12 Feb 2027. Its registration still delegates to this
# zone's Route53 nameservers, so the zone stays (with no records) until then: deleting it would
# let anyone create an ethanr.uk zone on those nameservers. Remove it once the domain has lapsed.
resource "aws_route53_zone" "legacy" {
  count = var.manage_dns_zone ? 1 : 0

  name = "ethanr.uk"

  tags = local.default_tags
}

moved {
  from = aws_route53_zone.main
  to   = aws_route53_zone.legacy
}
