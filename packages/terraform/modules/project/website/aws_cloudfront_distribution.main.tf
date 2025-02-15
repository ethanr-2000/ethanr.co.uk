resource "aws_cloudfront_distribution" "main" {
  origin {
    domain_name              = aws_s3_bucket.assets.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.oac.id
    origin_id                = local.s3_origin_id
    origin_path              = "/current/website"
  }

  enabled             = true
  is_ipv6_enabled     = true
  comment             = var.unique_ids.local
  default_root_object = "index.html"

  aliases = [var.fqdn, "*.${var.fqdn}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD"]
    target_origin_id = local.s3_origin_id

    origin_request_policy_id = "88a5eaf4-2fd4-4709-b370-b4c650ea3fcf" # Managed-CORS-S3Origin
    # viewer_protocol_policy   = "allow-all"
    viewer_protocol_policy   = "redirect-to-https" # TODO switch to this once we have a valid SSL certificate
    cache_policy_id          = "658327ea-f89d-4fab-a63d-7e88639e58f6" # Managed-CachingOptimized
  }

  custom_error_response {
    error_code            = 400
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response {
    error_code            = 403
    response_code         = 200
    response_page_path    = "/index.html"
  }

  custom_error_response {
    error_code            = 404
    response_code         = 200
    response_page_path    = "/index.html"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "whitelist"
      locations        = ["US", "CA", "GB", "DE", "FR", "ES"]
    }
  }

  tags = local.default_tags

  # viewer_certificate {
  #   cloudfront_default_certificate = true
  # }

  viewer_certificate {
    acm_certificate_arn      = var.ssl_certificate_arn
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2021"
  }
}