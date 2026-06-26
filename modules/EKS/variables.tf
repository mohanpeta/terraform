variable "environment" {
  type = string
}

variable "cluster_role_arn" {
  type = string
}

variable "node_role_arn" {
  type = string
}

variable "kms_key_arn" {
  type = string
}

variable "private_subnet_ids" {
  type = list(string)
}

variable "cluster_security_group_id" {
  type = string
}

variable "node_security_group_id" {
  type = string
}

variable "clusters" {
  description = "Map of EKS clusters"

  type = map(object({

    version = string

    endpoint_private_access = bool

    endpoint_public_access = bool

    enabled_log_types = list(string)

    node_groups = map(object({

      instance_types = list(string)

      capacity_type = string

      desired_size = number

      min_size = number

      max_size = number

      disk_size = number

    }))

  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}

