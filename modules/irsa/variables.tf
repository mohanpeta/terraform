variable "cluster_name" {
  type = string
}

variable "oidc_provider_arn" {
  type = string
}

variable "oidc_provider_url" {
  type = string
}

variable "irsa_roles" {

  description = "Map of IRSA roles"

  type = map(object({

    namespace       = string
    service_account = string
    policy_arns     = list(string)

  }))

}

variable "tags" {
  type    = map(string)
  default = {}
}
