variable "aws_region" {
  type    = string
  default = "eu-west-2"
}

variable "aws_prefix" {
  type = string

  validation {
    condition     = can(regex("^[0-9a-z]{4,14}$", var.aws_prefix))
    error_message = "The prefix must contain between 4 and 10 only lowercase letters and numbers"
  }
}

variable "cloudflare_zone_id" {
  type = string
}

variable "cloudflare_api_token" {
  type        = string
  description = "Cloudflare token with DNS:Edit permissions"
}

variable "acme_email" {
  type        = string
  description = "Email for LetsEncrpyt"
}
