output "cluster_endpoint" {
  description = "eks cluster end point"
  value       =  aws_eks_cluster.main-EKS-CLUSTER.endpoint
}




