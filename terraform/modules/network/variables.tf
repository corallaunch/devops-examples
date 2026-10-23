variable "name" {
  description = "Name prefix for all resources."
  type        = string
}

variable "cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
  default     = "10.20.0.0/16"
}

variable "az_count" {
  description = "Number of availability zones to use (2 or 3)."
  type        = number
  default     = 3
  validation {
    condition     = var.az_count >= 2 && var.az_count <= 3
    error_message = "az_count must be 2 or 3."
  }
}

variable "one_nat_per_az" {
  description = "true = one NAT gateway per zone (more resilient). false = one shared NAT gateway (cheaper)."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Tags added to every resource."
  type        = map(string)
  default     = {}
}
