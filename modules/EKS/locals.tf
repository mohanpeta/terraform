locals {

  name_prefix = "eks-${var.environment}"

  common_tags = merge(
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Project     = "EKS-Platform"
      Module      = "eks"
    },
    var.tags
  )

}
