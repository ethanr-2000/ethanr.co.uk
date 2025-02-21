resource "aws_cloudfront_origin_access_control" "lambda" {
  name                              = "${local.unique_id_account}-lambda-oac"
  description                       = "Lambda OAC"
  origin_access_control_origin_type = "lambda"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}
