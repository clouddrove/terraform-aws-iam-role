# Terraform Configuration for AWS IAM GitHub OIDC Role

Creates an IAM role that trust the IAM GitHub OIDC provider.

## Prerequisites

Before using this configuration, make sure you have the following prerequisites:

- [Terraform](https://www.terraform.io/) installed on your local machine.
- Appropriate AWS credentials and permissions to create IAM resources.

## Example
```bash
  module "aws_oidc_role" {
  source = "clouddrove/iam-role/aws"

  # Module input variables
  iam_github_oidc_role_enable    = true
  provider_url                   = "https://token.actions.githubusercontent.com"
  oidc_github_repos              = ["username/reponame"]
  role_name                      = "GitHub-Deploy-Role"
  oidc_provider_exists           = false
  name                           = "app"                  #For taggs
  repository                     = "repository-name"      #For taggs
  environment                    = "control-tower"        #Environment for tag
  managedby                      = "hello@clouddrove.com"
}
```

4. Initialize the Terraform working directory:

   ```bash
   terraform init

5. Review the Terraform plan:

   ```bash
   terraform plan

5. Apply the configuration to create the AWS resources:

   ```bash
   terraform apply

6. Confirm the changes by typing yes when prompted.
7. The configuration will create the specified IAM Role and OpenID Connect Provider. If var.enable is set to true, it will also attach the AdministratorAccess policy to the IAM Role.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| enable | Whether to create AWS oidc GitHUb role or not. | `bool` | false | yes |
| oidc_provider_exists | Mention oidc provider exist or not in true or false. | `bool` | false | yes |
| role_name  | Role name . | `string` | `GitHub-Deploy-Role` | yes |
| oidc_github_repos   | GitHub repository to set IAM Role conditions . | `list(string)` | `""` | yes |
| provider_url | URL for the OIDC provider. | `string` | `https://token.actions.githubusercontent.com` | yes |
| environment | Environment for tag, (e.g. `prod`, `dev`, `staging`). | `string` | `""` | yes |
| managedby | ManagedBy for tag, eg 'CloudDrove' | `string` | `"hello@clouddrove.com"` | yes |
| name | Name for tag  (e.g. `app` or `cluster`). | `string` | `""` | yes |
| repository | repsoitory name for tag| `string` | `""` | yes |
| policy_arns | A list of ARNs of policies to attach to the IAM role| `list(string)` | `["arn:aws:iam::aws:policy/AdministratorAccess"]` | yes |

## Cleanup
1. To destroy the created resources, run:
   ```bash
   terraform destroy
   
2. Confirm the destruction by typing yes when prompted.
