variable "clusters" {
  description = "Map of EKS clusters"

  type = map(object({
    oidc_issuer_url = string
    cluster_name    = string
  }))
}

variable "tags" {
  type    = map(string)
  default = {}
}
