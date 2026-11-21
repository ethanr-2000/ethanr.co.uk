##
# Basic Required Variables for tfscaffold Components
##

variable "tfscaffold_bucket_prefix" {
  type        = string
  description = "The tfscaffold bucket prefix (mostly for constructing remote states)"
}

variable "project" {
  type        = string
  description = "The tfscaffold project"
}

variable "aws_account_id" {
  type        = string
  description = "The AWS Account ID (numeric)"
}

variable "region" {
  type        = string
  description = "The AWS Region"
}

variable "group" {
  type        = string
  description = "The group variables are being inherited from (often synonmous with account short-name)"
  default     = ""
}

variable "environment" {
  type        = string
  description = "The environment variables are being inherited from"
}

##
# tfscaffold variables specific to this component
##

variable "default_tags" {
  type        = map(string)
  description = "A map of default tags to apply to all taggable resources within the component"
  default     = {}
}

##
# Variables specific to the "ethanr" Component
##

variable "cloudflare_zone_id" {
  type        = string
  description = "The Cloudflare zone ID for the site's domain"
}

variable "manage_dns_zone" {
  type        = bool
  description = "Whether this environment manages zone-wide DNS settings. Only one environment should"
  default     = false
}

variable "fqdn" {
  type        = string
  description = "The FQDN of the website"
  default     = "ethanr.co.uk"
}

