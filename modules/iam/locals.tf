locals {

  name_prefix = "eks-${var.environment}"

  common_tags = merge(
    {
      Environment = var.environment
      ManagedBy   = "Terraform"
      Module      = "iam"
    },
    var.tags
  )

}
