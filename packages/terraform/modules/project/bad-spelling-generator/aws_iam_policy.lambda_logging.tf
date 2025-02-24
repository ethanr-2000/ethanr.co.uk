resource "aws_iam_policy" "lambda_logging" {
  name        = "${local.unique_id}-logging"
  path        = "/"
  description = "IAM policy for logging from a lambda"
  policy      = data.aws_iam_policy_document.lambda_logging.json
}
