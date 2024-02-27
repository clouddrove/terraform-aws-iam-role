locals {
  tags = {
    "name"        = var.name
    "repository"  = var.repository
    "environment" = var.environment
    "managedby"   = var.managedby
  }
}

data "tls_certificate" "github" {
  count = var.enable ? 1 : 0
  url   = var.provider_url
}

data "aws_iam_openid_connect_provider" "github" {
  count = var.enable && var.oidc_provider_exists ? 1 : 0
  url   = var.provider_url
}

resource "aws_iam_openid_connect_provider" "github" {
  count           = var.enable && !var.oidc_provider_exists ? 1 : 0
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.github[0].certificates[0].sha1_fingerprint]
  url             = var.provider_url
  tags            = local.tags
}

# Include the role resource and attachment here

resource "aws_iam_role" "github" {
  count = var.enable ? 1 : 0
  name  = var.role_name
  tags  = local.tags
 assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = var.oidc_provider_exists ? data.aws_iam_openid_connect_provider.github[0].arn : aws_iam_openid_connect_provider.github[0].arn

        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          },
          "ForAnyValue:StringLike" = {
            "token.actions.githubusercontent.com:sub" = [
              for repo in var.oidc_github_repos : "repo:${repo}:*"
            ]
          }
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "github" {
  count      = var.enable ? length(var.policy_arns) : 0
  role       = aws_iam_role.github[0].name
  policy_arn = var.policy_arns[count.index]
}