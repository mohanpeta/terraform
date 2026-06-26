locals {
  name_prefix = "eks-${var.environment}"

  common_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
  }
}
