##
# Generic tfscaffold Module Variables
##

variable "unique_ids" {
  type = object({
    local   = string
    account = optional(string, null) # Not used in this module
    global  = optional(string, null) # Not used in this module
  })
}

##
# Variables specific to this Module
##

variable "cloudflare_account_id" {
  type        = string
  description = "The Cloudflare account ID"
}

variable "cloudflare_zone_id" {
  type        = string
  description = "The Cloudflare zone ID"
}

variable "fqdn" {
  type        = string
  description = "The fully qualified domain name"
}
