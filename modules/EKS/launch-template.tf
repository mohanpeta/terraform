resource "aws_launch_template" "node" {

  for_each = {
    for cluster_name, cluster in var.clusters :
    cluster_name => cluster
  }

  name_prefix = "${var.environment}-${each.key}-lt"

  ############################################
  # Block device mapping (root volume)
  ############################################
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 50
      volume_type           = "gp3"
      encrypted             = true
      delete_on_termination = true
    }
  }

  ############################################
  # Metadata options (security best practice)
  ############################################
  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"   # IMDSv2 enforced
  }

  ############################################
  # Monitoring
  ############################################
  monitoring {
    enabled = true
  }

  ############################################
  # Tagging
  ############################################
  tag_specifications {
    resource_type = "instance"

    tags = merge(
      local.common_tags,
      {
        Name = "${each.key}-node"
      }
    )
  }

  lifecycle {
    create_before_destroy = true
  }
}
