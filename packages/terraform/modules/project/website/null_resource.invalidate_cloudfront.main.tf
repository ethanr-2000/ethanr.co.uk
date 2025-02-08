# TODO: Error running command 'aws cloudfront create-invalidation --distribution-id E3EE1KRQ3U4BM3 --paths '/*'': exit status 254. Output:
# An error occurred (InvalidArgument) when calling the CreateInvalidation operation: Your request contains one or more invalid invalidation paths.

# resource "null_resource" "invalidate_cloudfront" {
#   # Only run this when the assets have changed
#   triggers = {
#     run_id = local.assets_md5
#   }

#   provisioner "local-exec" {
#     command = "aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.main.id} --paths '/*'"
#   }

#   depends_on = [ aws_s3_object.assets_current ]
# }