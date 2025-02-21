resource "aws_cloudfront_cache_policy" "api" {
  name        = "${local.unique_id_account}-API"
  comment     = "Cache policy for the bad spelling generator API"
  default_ttl = 60 * 60 * 24 * 30 # 30 days
  max_ttl     = 60 * 60 * 24 * 90 # 90 days
  min_ttl     = 60 * 60 * 24 * 1  # 1 day
  
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }

    headers_config {
      header_behavior = "none"
    }

    query_strings_config {
      query_string_behavior = "whitelist"
      
      query_strings {
        items = ["text"]
      }
    }

    enable_accept_encoding_brotli = true
    enable_accept_encoding_gzip   = true
  }
}
