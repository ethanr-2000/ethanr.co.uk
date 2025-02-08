##
# Generic tfscaffold Module Variables
##

variable "aws" {
  type = object({
    account_id   = string
    default_tags = optional(map(string), {})
    partition    = optional(string, "aws")
    region       = string
    url_suffix   = optional(string, "amazonaws.com")
  })
}

variable "module_parents" {
  type        = list(string)
  description = "List of parent module names"
  default     = []
}

variable "unique_ids" {
  type = object({
    local   = string
    account = optional(string, null)
    global  = optional(string, null)
  })
}

##
# Variables specific to this Module
##

variable fqdn {
  type        = string
  description = "The fully qualified domain name for the website"
}

variable package_version {
  type        = string
  description = "The version of the website. E.g. 1.2.13"
}
