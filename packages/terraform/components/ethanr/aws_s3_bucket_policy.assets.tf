resource "aws_s3_bucket_policy" "assets" {
  bucket = aws_s3_bucket.assets.bucket
  policy = data.aws_iam_policy_document.assets_oac.json
}
