resource "aws_cloudwatch_log_group" "main" {
  name              = aws_lambda_function.main.function_name
  retention_in_days = 14
}
