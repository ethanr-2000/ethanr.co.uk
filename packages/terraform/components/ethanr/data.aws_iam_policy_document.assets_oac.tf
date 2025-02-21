data "aws_iam_policy_document" "assets_oac" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions   = ["s3:GetObject"]
    resources = ["${aws_s3_bucket.assets.arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = [
        module.website.cloudfront_arn,
        module.bad-spelling-generator.cloudfront_arn,
      ]
    }
  }
}
