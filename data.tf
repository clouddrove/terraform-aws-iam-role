data "aws_caller_identity" "current" {
  provider = aws
}

data "aws_iam_policy_document" "default_assume_role" {
  count = var.enabled ? 1 : 0
  statement {
    effect = "Allow"

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"]
    }

    actions = ["sts:AssumeRole"]
  }
}