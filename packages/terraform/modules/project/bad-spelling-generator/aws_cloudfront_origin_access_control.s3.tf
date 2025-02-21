resource "aws_cloudfront_origin_access_control" "s3" {
  name                              = "${local.unique_id_account}-s3-oac"
  description                       = "S3 OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
