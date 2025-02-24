resource "aws_lambda_function" "main" {
  function_name = local.unique_id
  description   = "Bad Spelling Generator Lambda"
  runtime       = "python3.11"
  handler       = "index.handler"
  memory_size   = 1024
  timeout       = 3
  role          = aws_iam_role.lambda.arn
  publish       = true

  filename = local.lambda_zip_output_path
  source_code_hash = data.archive_file.lambda_source.output_base64sha256

  tags = local.default_tags
}
