resource "aws_eks_cluster" "this" {

  for_each = var.clusters

  name = each.key

  role_arn = var.cluster_role_arn

  version = each.value.version

  enabled_cluster_log_types = each.value.enabled_log_types

  access_config {
    authentication_mode = "API_AND_CONFIG_MAP"
  }

  vpc_config {

    subnet_ids = var.private_subnet_ids

    security_group_ids = [
      var.cluster_security_group_id
    ]

    endpoint_private_access = each.value.endpoint_private_access

    endpoint_public_access = each.value.endpoint_public_access

  }

  encryption_config {

    provider {
      key_arn = var.kms_key_arn
    }

    resources = [
      "secrets"
    ]
  }

  tags = merge(
    local.common_tags,
    {
      Name = each.key
    }
  )

}
