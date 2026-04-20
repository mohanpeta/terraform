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


resource "aws_s3_bucket" "terraform_state" {
  bucket = "EKS-Practice-bucket1010"
  lifecycle {
    prevent_destroy = false
  }
  
}


