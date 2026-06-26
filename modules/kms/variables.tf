variable "environment" {
  description = "Environment name"
  type        = string
}

variable "deletion_window_in_days" {
  description = "KMS key deletion window"
  type        = number
  default     = 30
}

variable "enable_key_rotation" {
  description = "Enable automatic rotation"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
