
locals {

  policy_attachments = flatten([

    for role_name, role in var.irsa_roles : [

      for policy in role.policy_arns : {

        role_name = role_name

        policy_arn = policy

        key = "${role_name}-${basename(policy)}"

      }

    ]

  ])

}


resource "aws_iam_role_policy_attachment" "this" {

  for_each = {

    for item in local.policy_attachments :

    item.key => item

  }

  role       = aws_iam_role.this[each.value.role_name].name

  policy_arn = each.value.policy_arn

}
