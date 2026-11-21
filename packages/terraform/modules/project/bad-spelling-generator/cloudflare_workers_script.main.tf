# Serves the site's static files and forwards /api to the Lambda, signing each call
resource "cloudflare_workers_script" "main" {
  account_id         = var.cloudflare_account_id
  script_name        = local.unique_id
  compatibility_date = "2026-11-01"

  main_module    = "index.js"
  content_file   = local.worker_script_path
  content_sha256 = filesha256(local.worker_script_path)

  assets = {
    directory = local.site_asset_root
  }

  bindings = [
    {
      name = "ASSETS"
      type = "assets"
    },
    {
      name = "LAMBDA_URL"
      type = "plain_text"
      text = aws_lambda_function_url.main.function_url
    },
    {
      name = "AWS_REGION"
      type = "plain_text"
      text = var.aws["region"]
    },
    {
      name = "AWS_ACCESS_KEY_ID"
      type = "plain_text"
      text = aws_iam_access_key.worker.id
    },
    {
      name = "AWS_SECRET_ACCESS_KEY"
      type = "secret_text"
      text = aws_iam_access_key.worker.secret
    },
  ]
}
