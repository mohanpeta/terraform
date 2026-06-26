
resource "aws_eks_access_entry" "this" {

  for_each = var.clusters

  cluster_name = aws_eks_cluster.this[each.key].name

  principal_arn = var.cluster_admin_role_arn

  type = "STANDARD"

}
#  Attach admin policy

resource "aws_eks_access_policy_association" "admin" {

  for_each = var.clusters

  cluster_name = aws_eks_cluster.this[each.key].name

  principal_arn = var.cluster_admin_role_arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }

}
