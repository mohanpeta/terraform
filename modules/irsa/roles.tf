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
          }
        }
      }

    ]

  })

  tags = var.tags

}


#  policies attachment

resource "aws_iam_role_policy_attachment" "this" {

  for_each = {
    for pair in flatten([
      for role_name, role in var.irsa_roles : [
        for policy in role.policy_arns : {
          key     = "${role_name}-${policy}"
          role    = role_name
          policy  = policy
        }
      ]
    ]) : pair.key => pair
  }

  role       = aws_iam_role.this[each.value.role].name
  policy_arn = each.value.policy
}
