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
    key          =  "dev/terraform-state-file"           # path/to/state
    use_lockfile = true
    region       = "ap-south-1"
    encrypt      =  true
  }
}


