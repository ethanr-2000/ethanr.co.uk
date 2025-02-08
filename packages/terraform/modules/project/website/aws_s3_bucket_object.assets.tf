resource "aws_s3_object" "assets_current" {
  for_each = local.assets_file_paths

  bucket = aws_s3_bucket.assets.bucket
  key    = "current/website/${each.value}"
  source = "${local.asset_root}/${each.value}"

  etag = filemd5("${local.asset_root}/${each.value}")

  content_type = lookup(local.mime_types, regex(".*\\.([a-zA-Z0-9]+)$", each.value)[0], "application/octet-stream")
  acl          = "public-read"
}

resource "aws_s3_object" "assets" {
  for_each = local.assets_file_paths

  bucket = aws_s3_bucket.assets.bucket
  key    = "${var.package_version}/website/${each.value}"
  source = "${local.asset_root}/${each.value}"

  etag = filemd5("${local.asset_root}/${each.value}")

  content_type = lookup(local.mime_types, regex(".*\\.([a-zA-Z0-9]+)$", each.value)[0], "application/octet-stream")
  acl          = "public-read"
}