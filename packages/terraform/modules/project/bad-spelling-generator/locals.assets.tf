locals {
  mime_types = {
    "html" = "text/html"
    "css"  = "text/css"
    "js"   = "application/javascript"
    "json" = "application/json"
    "xml"  = "application/xml"
    "txt"  = "text/plain"
    "png"  = "image/png"
    "jpg"  = "image/jpeg"
    "jpeg" = "image/jpeg"
    "gif"  = "image/gif"
    "svg"  = "image/svg+xml"
    "ico"  = "image/x-icon"
    "webp" = "image/webp"
    "csv"  = "text/csv"
  }

  work_dir = "${path.module}/work"
  
  asset_root = "${path.module}/../../../../../build"
  site_asset_root = "${local.asset_root}/ethanr.co.uk-bsg-site"
  lambda_asset_root = "${local.asset_root}/ethanr.co.uk-bsg-lambda"

  site_assets_file_paths = fileset(local.site_asset_root, "**")
  lambda_assets_file_paths = fileset(local.lambda_asset_root, "**")

  site_assets_md5 = jsonencode({ for path in local.site_assets_file_paths : path => filemd5("${local.site_asset_root}/${path}") })
  lambda_assets_md5 = jsonencode({ for path in local.lambda_assets_file_paths : path => filemd5("${local.lambda_asset_root}/${path}") })

  lambda_zip_output_path = "${local.work_dir}/lambda.zip"
}
