
resource "aws_eks_addon" "this" {

  for_each = {
    for item in local.cluster_addons :
    "${item.cluster}-${item.addon}" => item
  }

  cluster_name = aws_eks_cluster.this[each.value.cluster].name

  addon_name = each.value.addon

  resolve_conflicts = "OVERWRITE"

  depends_on = [
    aws_eks_cluster.this
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${each.value.cluster}-${each.value.addon}"
    }
  )
}
