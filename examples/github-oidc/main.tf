provider "aws" {
  region = "eu-west-1"
}

data "aws_caller_identity" "current" {}

locals {
  name        = "role-test"
  environment = "test"

  github_oidc_provider_arn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/token.actions.githubusercontent.com"
}

##-----------------------------------------------------------------------------
## GitHub OIDC role module call.
##-----------------------------------------------------------------------------

module "aws_github_oidc_role" {
  source = "../../modules/aws_github_oidc_role"

  environment          = local.environment
  role_name            = "github-oidc-terraform-role"
  repository           = "terraform-aws-iam-role"
  oidc_github_repos    = ["clouddrove/terraform-aws-iam-role"]
  oidc_provider_exists = true
  provider_url         = "https://token.actions.githubusercontent.com"
  policy_arns          = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  oidc_thumbprint_list = []
}

##-----------------------------------------------------------------------------
## GitHub OIDC role for repositories created after July 15 2026.
## Uses the immutable sub-claim format.
##-----------------------------------------------------------------------------

module "aws_github_oidc_role_custom_policy" {
  source = "../../modules/aws_github_oidc_role"

  role_name            = "github-oidc-terraform-role-immutable"
  environment          = local.environment
  oidc_provider_exists = true
  provider_url         = "https://token.actions.githubusercontent.com"
  oidc_github_repos    = []
  policy_arns          = ["arn:aws:iam::aws:policy/AdministratorAccess"]

  custom_assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Federated = local.github_oidc_provider_arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          }

          "ForAnyValue:StringLike" = {
            "token.actions.githubusercontent.com:sub" = [
              "repo:clouddrove@123456/terraform-aws-iam-role@78953:ref:refs/heads/main"
            ]
          }
        }
      }
    ]
  })
}
