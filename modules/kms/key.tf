resource "aws_kms_key" "eks" {

  description = "KMS key for EKS encryption"

  deletion_window_in_days = var.deletion_window_in_days

  enable_key_rotation = var.enable_key_rotation

  policy = data.aws_iam_policy_document.kms.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-kms-key"
    }
  )

}
