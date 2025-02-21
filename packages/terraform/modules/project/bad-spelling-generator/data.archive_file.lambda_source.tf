data "archive_file" "lambda_source" {
  depends_on = [ null_resource.lambda_sources_trigger ]
  type        = "zip"
  source_dir  = local.lambda_asset_root
  output_path = local.lambda_zip_output_path
}

resource "null_resource" "lambda_sources_trigger" {
  # This resource will be recreated when lambda_source_hash changes.
  triggers = {
    lambda_source_hash = local.lambda_assets_md5
  }
}
