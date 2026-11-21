# Nothing serves from this bucket any more. force_destroy lets a later change delete it
# even if it holds objects Terraform doesn't manage
resource "aws_s3_bucket" "assets" {
  bucket = "${local.unique_id_global}-assets"

  force_destroy = true

  tags = local.default_tags
}
