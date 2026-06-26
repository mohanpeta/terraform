#  Cluster security group

resource "aws_security_group" "cluster" {

  name = "${local.name_prefix}-cluster-sg"

  description = "EKS Cluster Security Group"

  vpc_id = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-cluster-sg"
    }
  )
}


# worker node security group

resource "aws_security_group" "node" {

  name = "${local.name_prefix}-node-sg"

  description = "EKS Worker Node SG"

  vpc_id = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-node-sg"
    }
  )
}



# ALB Security group


resource "aws_security_group" "alb" {

  name = "${local.name_prefix}-alb-sg"

  description = "Application Load Balancer SG"

  vpc_id = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-alb-sg"
    }
  )
}


