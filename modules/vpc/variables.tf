variable "region" {
    type = string
    description = "aws region"
}


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
  type        = list(string)
  description = " public subnet cidr block"
}


