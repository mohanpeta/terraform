locals {

  name_prefix = "eks-${var.environment}"

  common_tags = {
    Environment = var.environment
    ManagedBy   = "Terraform"
    Module      = "vpc"
  }

  az_count = length(var.availability_zones)

  ############################################
  # NAT LOGIC (NO HARD CODING)
  #
  # Priority:
  # 1. user-defined nat_gateway_count
  # 2. fallback = number of AZs
  ############################################
  nat_count = (
    var.nat_gateway_count != null
    ? var.nat_gateway_count
    : local.az_count
  )
}
