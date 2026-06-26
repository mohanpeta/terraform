variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "allowed_api_cidrs" {
  description = "CIDRs allowed to access the Kubernetes API"
  type        = list(string)

  default = [
    "0.0.0.0/0"
  ]
}

variable "tags" {
  description = "Additional tags"

  type = map(string)

  default = {}
}
