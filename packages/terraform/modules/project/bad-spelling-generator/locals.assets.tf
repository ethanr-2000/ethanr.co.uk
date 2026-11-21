locals {
  work_dir = "${path.module}/work"

  asset_root        = "${path.module}/../../../../../build"
  site_asset_root   = "${local.asset_root}/ethanr.co.uk-bsg-site"
  lambda_asset_root = "${local.asset_root}/ethanr.co.uk-bsg-lambda"

  lambda_assets_file_paths = fileset(local.lambda_asset_root, "**")

  lambda_assets_md5 = jsonencode({ for path in local.lambda_assets_file_paths : path => filemd5("${local.lambda_asset_root}/${path}") })

  lambda_zip_output_path = "${local.work_dir}/lambda.zip"

  worker_script_path = "${path.module}/worker/index.js"
}
