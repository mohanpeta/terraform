variable "vpc_cidr" {
  type        = string
  description = "vpc cidr block"
}

variable "public_subnet_cidr" {
  type        = list(string)
  description = " public subnet cidr block"
}


variable "private_subnet_cidr" {
  type        = list(string)
  description = " public subnet cidr block"
}

variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)

}

variable "region" {
  description = "AWS region"
  type        = string

}





variable "EKS-CLUSTER-NAME" {
  type        = string
  description = "Eks cluster name"
}



variable "EKS-Cluster-Version" {
  type        = string
  description = "Eks cluster Version"
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





