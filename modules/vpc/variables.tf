variable "vpc_cidr" {
  type = string
}

variable "environment" {
  type = string
}

variable "availability_zones" {
  type = list(string)
}

variable "public_subnets" {
  type = list(string)
}

variable "private_subnets" {
  type = list(string)
}

############################################
# NEW: NAT CONTROL (NO HARDCODING)
############################################
variable "nat_gateway_count" {
  type    = number
  default = null

  validation {
    condition = var.nat_gateway_count == null || var.nat_gateway_count >= 1
    error_message = "NAT Gateway count must be >= 1"
  }
}

variable "enable_flow_logs" {
  type    = bool
  default = true
}
