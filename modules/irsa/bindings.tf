locals {

  service_accounts = {

    for role_name, role in var.irsa_roles :

    role_name => {

      namespace = role.namespace

      service_account = role.service_account

      role_arn = aws_iam_role.this[role_name].arn

    }

  }

}

