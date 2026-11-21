# Lets the Cloudflare Worker call the Lambda's function URL, and nothing else
data "aws_iam_policy_document" "worker" {
  statement {
    effect    = "Allow"
    actions   = ["lambda:InvokeFunctionUrl"]
    resources = [aws_lambda_function.main.arn]

    condition {
      test     = "StringEquals"
      variable = "lambda:FunctionUrlAuthType"
      values   = ["AWS_IAM"]
    }
  }

  statement {
    effect    = "Allow"
    actions   = ["lambda:InvokeFunction"]
    resources = [aws_lambda_function.main.arn]

    condition {
      test     = "Bool"
      variable = "lambda:InvokedViaFunctionUrl"
      values   = ["true"]
    }
  }
}
