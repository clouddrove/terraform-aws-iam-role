# terraform-aws-iam-role basic example

This is a basic example of the `terraform-aws-iam-role` module.

## Usage

```hcl
module "iam_role" {
  source      = "clouddrove/iam-role/aws"
  name        = "iam-role"
  environment = "test"
}
```
