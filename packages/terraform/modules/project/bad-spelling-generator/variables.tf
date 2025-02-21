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

variable "acm_certificate_arn" {
  type        = string
  description = "The ARN of the ACM certificate"
  
}

variable "hosted_zone_id" {
  type        = string
  description = "The Route 53 hosted zone ID"
}

variable "fqdn" {
  type        = string
  description = "The fully qualified domain name"
}

variable "s3_path" {
  type        = string
  description = "The path to the website assets in the S3 bucket"
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of the assets S3 bucket"
}

variable "s3_bucket_regional_domain_name" {
  type        = string
  description = "The regional domain name of the assets S3 bucket"
}

variable "s3_bucket_arn" {
  type        = string
  description = "The ARN of the assets S3 bucket"
}

variable package_version {
  type        = string
  description = "The version of the website. E.g. 1.2.13"
}
