resource "aws_iam_role" "this" {

  for_each = var.irsa_roles

  name = "${local.name_prefix}-${each.key}"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {
          Federated = var.oidc_provider_arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {

          StringEquals = {

            "${replace(var.oidc_provider_url, "https://", "")}:sub" =
            "system:serviceaccount:${each.value.namespace}:${each.value.service_account}"

            "${replace(var.oidc_provider_url, "https://", "")}:aud" =
            "sts.amazonaws.com"

          }

        }

      }

    ]

  })

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-${each.key}"
    }
  )

}
