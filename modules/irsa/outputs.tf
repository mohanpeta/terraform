output "irsa_role_arns" {
  value = {
    for k, v in aws_iam_role.this :
    k => v.arn
  }
}

output "irsa_role_names" {
  value = {
    for k, v in aws_iam_role.this :
    k => v.name
  }
}


output "service_account_bindings" {

  value = local.service_accounts

}
