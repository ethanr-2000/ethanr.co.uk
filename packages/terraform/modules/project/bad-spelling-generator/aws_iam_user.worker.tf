# The Cloudflare Worker signs its calls to the Lambda's function URL as this user
resource "aws_iam_user" "worker" {
  name = "${local.unique_id}-worker"

  tags = local.default_tags
}

resource "aws_iam_user_policy" "worker" {
  name   = "invoke-function-url"
  user   = aws_iam_user.worker.name
  policy = data.aws_iam_policy_document.worker.json
}

resource "aws_iam_access_key" "worker" {
  user = aws_iam_user.worker.name
}
