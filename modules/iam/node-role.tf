#  Node IAM Role

resource "aws_iam_role" "node" {

  name = "${local.name_prefix}-node-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "ec2.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

  tags = merge(local.common_tags, {

    Name = "${local.name_prefix}-node-role"

  })

}



#  Policy Attachment

resource "aws_iam_role_policy_attachment" "node" {

  for_each = toset([

    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",

    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryPullOnly",

    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"

  ])

  role = aws_iam_role.node.name

  policy_arn = each.value

}



