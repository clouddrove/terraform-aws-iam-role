provider "aws" {
  region = "us-east-1"
}

module "iam_role" {
  source      = "../../"
  name        = "clouddrove"
  environment = "test"
  label_order = ["environment", "name"]
}
