# Serves the site's static files and forwards /api to the Lambda, signing each call
module "worker" {
  source = "../../generic/cloudflare-worker"

  account_id       = var.cloudflare_account_id
  zone_id          = var.cloudflare_zone_id
  hostname         = var.fqdn
  script_path      = local.worker_script_path
  assets_directory = local.site_asset_root

  plain_text_bindings = {
    LAMBDA_URL        = aws_lambda_function_url.main.function_url
    AWS_REGION        = var.aws["region"]
    AWS_ACCESS_KEY_ID = aws_iam_access_key.worker.id
  }

  secret_bindings = {
    AWS_SECRET_ACCESS_KEY = aws_iam_access_key.worker.secret
  }

  unique_ids = {
    local = local.unique_id
  }
}
