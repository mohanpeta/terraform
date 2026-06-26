output "cluster_names" {
  value = [for k, v in aws_eks_cluster.this : v.name]
}


output "cluster_endpoints" {
  value = {
    for k, v in aws_eks_cluster.this :
    k => v.endpoint
  }
}

output "cluster_arns" {
  value = {
    for k, v in aws_eks_cluster.this :
    k => v.arn
  }
}
output "oidc_provider_urls" {
  value = {
    for k, v in aws_eks_cluster.this :
    k => v.identity[0].oidc[0].issuer
  }
}
output "node_group_ids" {
  value = {
    for k, v in aws_eks_node_group.this :
    k => v.id
  }
}
