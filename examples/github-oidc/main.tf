provider "aws" {
  region = "eu-west-1"
}

locals {
  name        = "role-test"
  environment = "test"
}

##----------------------------------------------------------------------------- 
## GitHub OIDC role module call.   
##-----------------------------------------------------------------------------

module "aws_github_oidc_role" {
  source = "../../modules/aws_github_oidc_role"

  enable               = true
  environment          = local.environment
  name                 = local.name
  repository           = "terraform-aws-iam-role"
  oidc_github_repos    = ["clouddrove/terraform-aws-iam-role"]
  role_name            = "github-oidc-terraform-role"
  oidc_provider_exists = true
  provider_url         = "https://token.actions.githubusercontent.com"
  policy_arns          = ["arn:aws:iam::aws:policy/AdministratorAccess"]

}

