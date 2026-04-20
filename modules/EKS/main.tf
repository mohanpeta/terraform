# IAM Role for EKS Cluster

resource "aws_iam_role" "eks-cluster-role" {
  name = "${var.EKS-CLUSTER-NAME}-eks-cluster-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "sts:AssumeRole"
        ]
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "cluster_AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-cluster-role
}


# EKS Cluster

resource "aws_eks_cluster" "main-EKS-CLUSTER" {
  name = var.EKS-CLUSTER-NAME
  role_arn = aws_iam_role.eks-cluster-role.arn
  version  = var.EKS-Cluster-Version

  vpc_config {
    subnet_ids = var.subnet_id
  }

  # Ensure that IAM Role permissions are created before and deleted
  # after EKS Cluster handling. Otherwise, EKS will not be able to
  # properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.cluster_AmazonEKSClusterPolicy,
  ]
}


# IAM role for worker nodes

resource "aws_iam_role" "eks_node_role" {
  name = "${var.EKS-CLUSTER-NAME}-eks-node-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = ["sts:AssumeRole"]
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "node_policies" {
  for_each = toset([
    "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy",
    "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy",
    "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  ])
  policy_arn = each.value
  role       = aws_iam_role.eks_node_role.name
}

# Node Group


resource "aws_eks_node_group" "eks_worker_node" {
  for_each = var.node_group

  cluster_name    = aws_eks_cluster.main-EKS-CLUSTER
  node_group_name = each.key
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = var.subnet_id

  instance_types = each.value.instance_types
  disk_size = each.value.capacity_type

  scaling_config {
    desired_size = each.value.scaling_config.desired_size
    max_size     = each.value.scaling_config.max_size
    min_size     = each.value.scaling_config.min_size
  }

  depends_on = [
    aws_iam_role_policy_attachment.node_policies
  ]
}

