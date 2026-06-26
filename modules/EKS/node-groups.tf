resource "aws_eks_node_group" "this" {

  for_each = {
    for pair in flatten([
      for cluster_name, cluster in var.clusters : [
        for ng_name, ng in cluster.node_groups : {
          key          = "${cluster_name}-${ng_name}"
          cluster      = cluster_name
          ng_name      = ng_name
          ng_config    = ng
        }
      ]
    ]) : pair.key => pair
  }

  ############################################
  # Cluster association
  ############################################
  cluster_name = aws_eks_cluster.this[each.value.cluster].name

  node_group_name = each.value.ng_name

  node_role_arn = var.node_role_arn

  subnet_ids = var.private_subnet_ids

  ############################################
  # Capacity type
  ############################################
  capacity_type = each.value.ng_config.capacity_type

  ############################################
  # Instance types
  ############################################
  instance_types = each.value.ng_config.instance_types

  ############################################
  # Scaling configuration
  ############################################
  scaling_config {
    desired_size = each.value.ng_config.desired_size
    min_size     = each.value.ng_config.min_size
    max_size     = each.value.ng_config.max_size
  }

  ############################################
  # Disk size
  ############################################
  disk_size = each.value.ng_config.disk_size

  ############################################
  # Launch template
  ############################################
  launch_template {
    id      = aws_launch_template.node[each.value.cluster].id
    version = "$Latest"
  }

  ############################################
  # Labels
  ############################################
  labels = each.value.ng_config.labels

  ############################################
  # Taints (dynamic)
  ############################################
  dynamic "taint" {
    for_each = each.value.ng_config.taints

    content {
      key    = taint.value.key
      value  = taint.value.value
      effect = taint.value.effect
    }
  }

  ############################################
  # Update config (safe rolling upgrades)
  ############################################
  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_eks_cluster.this,
    aws_launch_template.node
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${each.value.cluster}-${each.value.ng_name}"
    }
  )
}
