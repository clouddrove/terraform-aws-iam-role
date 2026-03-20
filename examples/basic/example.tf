provider "aws" {
  region = "us-east-1"
}

module "iam_role" {
  source      = "../../"
  name        = "iam-role"
  environment = "test"
}
