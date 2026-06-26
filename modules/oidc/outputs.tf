output "oidc_provider_arns" {
  value = {
    for k, v in aws_iam_openid_connect_provider.this :
    k => v.arn
  }
}

output "oidc_provider_urls" {
  value = {
    for k, v in aws_iam_openid_connect_provider.this :
    k => v.url
  }
}

output "oidc_provider_ids" {
  value = {
    for k, v in aws_iam_openid_connect_provider.this :
    k => v.id
  }
}
