provider "aws" {
  region = "us-east-1"
}

##-----------------------------------------------------------------------------
## Basic IAM role — name derived from labels (name + environment).
##-----------------------------------------------------------------------------
module "iam_role" {
  source      = "../../"
  name        = "iam-role"
  environment = "test"
}

##-----------------------------------------------------------------------------
## Basic IAM role — explicit role_name overrides the label-derived name.
##-----------------------------------------------------------------------------
module "iam_role_explicit_name" {
  source      = "../../"
  name        = "iam-role"
  environment = "test"
  role_name   = "my-explicit-iam-role"
}
