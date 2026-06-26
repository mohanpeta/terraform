resource "aws_kms_alias" "eks" {

  name = "alias/${local.name_prefix}"

  target_key_id = aws_kms_key.eks.key_id

}
