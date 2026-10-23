variable "name" {
  type    = string
  default = "demo-web"
}

variable "region" {
  type    = string
  default = "ap-southeast-1"
}

variable "environment" {
  type    = string
  default = "staging"
}

variable "certificate_arn" {
  description = "ACM certificate in the same region, for example arn:aws:acm:ap-southeast-1:123456789012:certificate/abc"
  type        = string
}

variable "image_tag" {
  description = "Image tag to deploy. The pipeline sets this to the Git commit SHA."
  type        = string
  default     = "latest"
}
