resource "aws_cloudfront_origin_access_control" "oac" {
  name                              = "${var.unique_ids.local}-s3-oac"
  description                       = "OAC for CloudFront"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}