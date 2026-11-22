locals {
  component = "ethanr"

  # Compound Scope Identifier
  unique_id = replace(
    format(
      "%s-%s-%s",
      var.project,
      var.environment,
      local.component,
    ),
    "_",
    "",
  )

  default_tags = merge(
    var.default_tags,
    {
      "Name"                   = local.unique_id
      "tfscaffold:project"     = var.project
      "tfscaffold:environment" = var.environment
      "tfscaffold:component"   = local.component
    },
    var.group != null ? { "tfscaffold:group" = var.group } : {}
  )
}

