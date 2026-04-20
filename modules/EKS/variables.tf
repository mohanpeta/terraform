variable "EKS-CLUSTER-NAME" {
  type        = string
  description = "Eks cluster name"
}



variable "EKS-Cluster-Version" {
  type        = string
  description = "Eks cluster Version"
}

variable "subnet_id" {
  type        = list(string)
  description = "VPC Subnet ids"
}

variable "node_group" {
  description = "EKS Node group configuration variables"

  type = map(object({
    instance_types = list(string)
    capacity_type = string
    scaling_config = object({
      desired_size = number
      max_size = number
      min_size = number
    }) 
  }))
}




