
variable "region" {
  type        = string
  description = "AWS region"
}

variable "project_name" {
  type        = string
  description = "Project name"
}

variable "environment" {
  type        = string

  validation {
    condition = contains(["dev", "qa", "stage", "prod"], var.environment)
    error_message = "Environment must be dev, qa, stage, or prod"
  }
}

variable "owner" {
  type        = string
  description = "Owner of infrastructure"
}

variable "state_bucket_name" {
  type        = string
  description = "Base name for S3 terraform state bucket"
}

variable "lock_table_name" {
  type        = string
  description = "DynamoDB lock table name"
}

variable "enable_force_destroy" {
  type    = bool
  default = false
}

variable "enable_versioning" {
  type    = bool
  default = true
}

variable "retention_days" {
  type    = number
  default = 90
}
