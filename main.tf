terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.97.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "terraform-state" {
  bucket = "practice-eks-terraform1010"
  lifecycle {
    prevent_destroy = false
  }
}


terraform {
  backend "s3" {
    bucket       = "practice-eks-terraform1010"
    key          = "dev/terraform-state-file" # path/to/state
    use_lockfile = true
    region       = "ap-south-1"
    encrypt      = true
  }
}


module "vpc" {
  source              = "./modules/vpc"
  region              = var.region
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidr  = var.public_subnet_cidr
  private_subnet_cidr = var.private_subnet_cidr
  availability_zones  = var.availability_zones
}

module "eks" {
  source = "./modules/EKS"

  EKS-CLUSTER-NAME    = var.EKS-CLUSTER-NAME
  subnet_id           = module.vpc.private_subnet_id
  EKS-Cluster-Version = var.EKS-Cluster-Version
  node_group          = var.node_group
  region              = var.region
  vpc_id              = module.vpc.vpc_id
}
