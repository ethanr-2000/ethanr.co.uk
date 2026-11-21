locals {
  name = var.unique_ids["local"]

  has_script = var.script_path != null
  has_assets = var.assets_directory != null

  bindings = concat(
    local.has_script && local.has_assets ? [{ name = var.assets_binding_name, type = "assets", text = null }] : [],
    [for name, text in var.plain_text_bindings : { name = name, type = "plain_text", text = text }],
    [for name in nonsensitive(keys(var.secret_bindings)) : { name = name, type = "secret_text", text = var.secret_bindings[name] }],
  )
}
