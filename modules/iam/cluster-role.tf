# cluster IAM Role
resource "aws_iam_role" "cluster" {

  name = "${local.name_prefix}-cluster-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {

        Effect = "Allow"

        Principal = {

          Service = "eks.amazonaws.com"

        }

        Action = "sts:AssumeRole"

      }

    ]

  })

  tags = merge(local.common_tags, {

    Name = "${local.name_prefix}-cluster-role"

  })

}




# cluster policy

resource "aws_iam_role_policy_attachment" "cluster" {

  role = aws_iam_role.cluster.name

  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"

}


