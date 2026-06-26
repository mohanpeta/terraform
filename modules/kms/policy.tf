data "aws_iam_policy_document" "kms" {

  statement {

    sid = "EnableRootPermissions"

    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }

    actions = [
      "kms:*"
    ]

    resources = [
      "*"
    ]
  }

}
