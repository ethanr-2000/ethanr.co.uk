##
# Generic tfscaffold Module Variables
##

variable "unique_ids" {
  type = object({
    local   = string                 # Used as the Worker's name
    account = optional(string, null) # Not used in this module
    global  = optional(string, null) # Not used in this module
  })
}

##
# Variables specific to this Module
##

variable "account_id" {
  type        = string
  description = "The Cloudflare account ID"
}

variable "zone_id" {
  type        = string
  description = "The Cloudflare zone ID for hostname. Cloudflare works it out from the hostname if left null"
  default     = null
}

variable "hostname" {
  type        = string
  description = "Custom domain to serve the Worker on, e.g. app.example.com. Null for no custom domain"
  default     = null
}

variable "assets_directory" {
  type        = string
  description = "Directory of static files to upload and serve. Null for a script-only Worker"
  default     = null
}

variable "not_found_handling" {
  type        = string
  description = "What an assets-only Worker returns for paths that don't match a file: single-page-application (index.html), 404-page or none. Ignored when there is a script, which handles those paths itself"
  default     = "single-page-application"

  validation {
    condition     = contains(["single-page-application", "404-page", "none"], var.not_found_handling)
    error_message = "not_found_handling must be single-page-application, 404-page or none."
  }
}

variable "asset_headers" {
  type        = string
  description = "Headers added to static file responses, in _headers file format. Null for none"
  default     = <<-EOT
    /*
      X-Content-Type-Options: nosniff
      X-Frame-Options: DENY
      Referrer-Policy: strict-origin-when-cross-origin
      Permissions-Policy: camera=(), microphone=(), geolocation=()
  EOT
}

variable "script_path" {
  type        = string
  description = "Path to a single-file ES module Worker script. Null for an assets-only Worker"
  default     = null
}

variable "assets_binding_name" {
  type        = string
  description = "Name the script uses to read the static files (env.ASSETS), when there are both"
  default     = "ASSETS"
}

variable "plain_text_bindings" {
  type        = map(string)
  description = "Plain text values available to the script as env.<NAME>"
  default     = {}
}

variable "secret_bindings" {
  type        = map(string)
  description = "Secret values available to the script as env.<NAME>"
  default     = {}
  sensitive   = true
}

variable "compatibility_date" {
  type        = string
  description = "Workers runtime compatibility date"
  default     = "2026-11-01"
}

variable "logs_enabled" {
  type        = bool
  description = "Whether to turn on Workers Logs"
  default     = true
}
