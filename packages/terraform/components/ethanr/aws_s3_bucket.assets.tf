resource "aws_s3_bucket" "assets" {
  bucket = "${local.unique_id_global}-assets"

  force_destroy = false

  tags = local.default_tags
}
