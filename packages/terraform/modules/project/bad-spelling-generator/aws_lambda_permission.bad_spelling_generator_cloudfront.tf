resource "aws_lambda_permission" "bad_spelling_generator_cloudfront" {
  statement_id  = "AllowExecutionFromCloudFront"
  action        = "lambda:InvokeFunctionUrl"
  function_name = aws_lambda_function_url.main.function_name
  principal     = "cloudfront.amazonaws.com"
  source_arn    = aws_cloudfront_distribution.main.arn
}
