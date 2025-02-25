resource "aws_s3_object" "site_assets_current" {
  for_each = local.site_assets_file_paths

  bucket = var.s3_bucket_name
  key    = "current/${var.s3_path}/${each.value}"
  source = "${local.site_asset_root}/${each.value}"

  etag = filemd5("${local.site_asset_root}/${each.value}")

  content_type = lookup(local.mime_types, regex(".*\\.([a-zA-Z0-9]+)$", each.value)[0], "application/octet-stream")
}

resource "aws_s3_object" "site_assets" {
  for_each = local.site_assets_file_paths

  bucket = var.s3_bucket_name
  key    = "${var.package_version}/${var.s3_path}/${each.value}"
  source = "${local.site_asset_root}/${each.value}"

  etag = filemd5("${local.site_asset_root}/${each.value}")

  content_type = lookup(local.mime_types, regex(".*\\.([a-zA-Z0-9]+)$", each.value)[0], "application/octet-stream")
}
