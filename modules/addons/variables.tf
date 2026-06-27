variable "cluster_name" {
  type = string
}

variable "cluster_endpoint" {
  type = string
}

variable "cluster_ca_certificate" {
  type = string
}

variable "cluster_auth_token" {
  type = string
  sensitive = true
}

variable "oidc_provider_arn" {
  type = string
}

variable "irsa_role_arns" {
  type = map(string)
}

variable "aws_managed_addons" {

  type = map(object({

    version = optional(string)

    resolve_conflicts = optional(string, "OVERWRITE")

  }))

}

variable "tags" {

  type = map(string)

  default = {}

}
