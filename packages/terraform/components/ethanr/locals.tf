locals {
  # get package version from package.json
  package_version = jsondecode(file("${path.module}/../../package.json")).version
}
