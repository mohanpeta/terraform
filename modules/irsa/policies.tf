
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
