provider "aws" {
  region = "eu-west-1"
}

module "iam-role" {
  source = "git::https://github.com/clouddrove/terraform-aws-iam-role.git?ref=tags/0.12.0"

  name               = "iam-role"
  application        = "clouddrove"
  environment        = "test"
  label_order        = ["application", "name", "name"]

  assume_role_policy = data.aws_iam_policy_document.default.json

  policy_enabled = true
  policy         = data.aws_iam_policy_document.iam-policy.json
}

data "aws_iam_policy_document" "default" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "iam-policy" {
  statement {
    actions = [
      "ssm:UpdateInstanceInformation",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
      "ssmmessages:OpenDataChannel"    ]
    effect    = "Allow"
    resources = ["*"]
  }
}