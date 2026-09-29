# Terraform Configuration for AWS IAM GitHub OIDC Role

Creates an IAM role that trust the IAM GitHub OIDC provider.

## Prerequisites

Before using this configuration, make sure you have the following prerequisites:

- [Terraform](https://www.terraform.io/) installed on your local machine.
- Appropriate AWS credentials and permissions to create IAM resources.

## Example
```bash
  module "aws_oidc_role" {
  source = "clouddrove/iam-role/aws//modules/aws_github_oidc_role"        

  # Module input variables
  provider_url                   = "https://token.actions.githubusercontent.com"
  oidc_github_repos              = ["username/reponame"]
  role_name                      = "GitHub-Deploy-Role"
  oidc_provider_exists           = false
  name                           = "app"                  #For taggs
  repository                     = "repository-name"      #For taggs
  environment                    = "control-tower"        #Environment for tag
  managedby                      = "hello@clouddrove.com"
  custom_assume_role_policy      = ""                     # If you have your own policy add this variable

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
| name | Name for tags. Also used to derive the IAM role name via the labels module when `role_name` is not set. | `string` | `""` | no |
| role_name | Explicit name for the IAM role. If not set, falls back to the label-derived name from `name` (via the labels module). | `string` | `""` | no |
| environment | Environment name for tags (e.g. `prod`, `dev`, `staging`). | `string` | n/a | yes |
| repository | Repository name for tags. | `string` | `"https://github.com/clouddrove/terraform-aws-iam-role.git"` | no |
| managedby | Managed by for tags. | `string` | `"hello@clouddrove.com"` | no |
| label_order | Label order, e.g. `name`, `environment`. | `list(any)` | `["name", "environment"]` | no |
| provider_url | The URL of the identity provider for the OIDC. | `string` | n/a | yes |
| oidc_github_repos | GitHub repository names for access (e.g. `["org/repo"]`). | `list(string)` | n/a | yes |
| oidc_provider_exists | Set to `true` if the GitHub OIDC provider already exists in the account; `false` to create it. | `bool` | `true` | no |
| oidc_thumbprint_list | Custom thumbprint list for the OIDC provider. If empty, the thumbprint is fetched automatically via TLS. | `list(string)` | `[]` | no |
| policy_arns | A list of IAM policy ARNs to attach to the role. | `list(string)` | n/a | yes |
| custom_assume_role_policy | Custom JSON trust policy for the IAM role. When set, overrides the module-generated GitHub OIDC trust policy entirely. Use this for advanced conditions such as GitHub's July 2026 immutable sub-claim format. | `string` | `""` | no |

## Cleanup
1. To destroy the created resources, run:
   ```bash
   terraform destroy
   
2. Confirm the destruction by typing yes when prompted.
