resource "aws_s3_bucket" "assets" {
  bucket = "${var.unique_ids.global}-assets"

  force_destroy = false

  tags = local.default_tags
}
