locals {
  thumbprint = "9e99a48a9960b14926bb7f3b02e22da0afd10df6"
}

resource "aws_iam_openid_connect_provider" "this" {

  for_each = var.clusters

  url = each.value.oidc_issuer_url

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    local.thumbprint
  ]

  tags = merge(
    var.tags,
    {
      Name = each.value.cluster_name
    }
  )
}
