locals {
  mime_types = {
    "html" = "text/html"
    "css"  = "text/css"
    "js"   = "application/javascript"
    "json" = "application/json"
    "xml"  = "application/xml"
    "txt"  = "text/plain"
    "png"  = "image/png"
    "jpg"  = "image/jpeg"
    "jpeg" = "image/jpeg"
    "gif"  = "image/gif"
    "svg"  = "image/svg+xml"
    "ico"  = "image/x-icon"
    "webp" = "image/webp"
    "csv"  = "text/csv"
  }
  
  asset_root = "${path.module}/../../../../../build/ethanr.co.uk-website"

  assets_file_paths = fileset(local.asset_root, "**")

  assets_md5 = jsonencode({ for path in local.assets_file_paths : path => filemd5("${local.asset_root}/${path}") })
}
