provider "aws" {
  region = "eu-west-1"
}

locals {
  name        = "role-test"
  environment = "test"
}

##----------------------------------------------------------------------------- 
## IAM role module call.   
##-----------------------------------------------------------------------------
module "iam-role" {
  source             = "./../../"
  name               = local.name
  environment        = local.environment
  assume_role_policy = data.aws_iam_policy_document.default.json
  policy_enabled     = true
  policy             = data.aws_iam_policy_document.iam-policy.json
}

##----------------------------------------------------------------------------- 
## Data block to create IAM policy.  
##-----------------------------------------------------------------------------
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

##----------------------------------------------------------------------------- 
## Data block to create IAM policy.  
##-----------------------------------------------------------------------------
data "aws_iam_policy_document" "iam-policy" {
  statement {
    actions = [
      "ssm:UpdateInstanceInformation",
      "ssmmessages:CreateControlChannel",
      "ssmmessages:CreateDataChannel",
      "ssmmessages:OpenControlChannel",
    "ssmmessages:OpenDataChannel"]
    effect    = "Allow"
    resources = ["*"]
  }
}

module "aws_github_oidc_role" { 
  source = "../../modules/aws_github_oidc_role"

  enable                      = true
  environment                 = local.environment
  name                        = local.name                       
  repository                  = "terraform-aws-control-tower"        
  oidc_github_repos           = ["clouddrove/terraform-aws-control-tower"] 
  role_name                   = "github-oidc-terraform-role"
  oidc_provider_exists        = true
  provider_url                = "https://token.actions.githubusercontent.com"
  policy_arns                 = ["arn:aws:iam::aws:policy/AdministratorAccess"]
  
  # Other module configurations...
}

