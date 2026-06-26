resource "aws_iam_instance_profile" "node" {

  name = "${local.name_prefix}-instance-profile"

  role = aws_iam_role.node.name

}
