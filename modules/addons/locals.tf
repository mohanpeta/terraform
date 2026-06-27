
locals {

  common_tags = merge(
    {
      ManagedBy = "Terraform"
      Module    = "addons"
    },
    var.tags
  )

}
