variable "name" {
  description = "Service name, used as a prefix."
  type        = string
}

variable "vpc_id" {
  type = string
}

variable "public_subnet_ids" {
  description = "Subnets for the load balancer."
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "Subnets for the app tasks."
  type        = list(string)
}

variable "certificate_arn" {
  description = "ACM certificate ARN for HTTPS."
  type        = string
}

variable "image" {
  description = "Container image, for example 123456789012.dkr.ecr.ap-southeast-1.amazonaws.com/app:1.0.0"
  type        = string
}

variable "container_port" {
  type    = number
  default = 8080
}

variable "health_check_path" {
  type    = string
  default = "/health"
}

variable "cpu" {
  type    = number
  default = 256
}

variable "memory" {
  type    = number
  default = 512
}

variable "cpu_architecture" {
  description = "X86_64 or ARM64 (Graviton, usually cheaper)."
  type        = string
  default     = "ARM64"
}

variable "min_count" {
  type    = number
  default = 2
}

variable "max_count" {
  type    = number
  default = 6
}

variable "cpu_target_percent" {
  type    = number
  default = 60
}

variable "environment" {
  description = "Plain environment variables. Put secrets in Secrets Manager, not here."
  type        = map(string)
  default     = {}
}

variable "log_retention_days" {
  type    = number
  default = 30
}

variable "tags" {
  type    = map(string)
  default = {}
}
