## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assume\_role\_policy | Whether to create Iam role. | `string` | `null` | no |
| custom\_assume\_role\_policy | Custom JSON assume-role policy for the OIDC role. Overrides the auto-generated policy. | `string` | `""` | no |
| description | The description of the role. | `string` | `""` | no |
| enabled | Whether to create Iam role. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| force\_detach\_policies | Whether to force detaching any policies the role has before destroying it. | `bool` | `true` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| managed\_policy\_arns | Set of exclusive IAM managed policy ARNs to attach to the IAM role | `list(any)` | `[]` | no |
| managedby | ManagedBy, eg 'CloudDrove' | `string` | `"hello@clouddrove.com"` | no |
| max\_session\_duration | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. | `number` | `3600` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| oidc\_enabled | When true, creates a GitHub OIDC IAM role via the aws\_github\_oidc\_role sub-module instead of the generic IAM role. | `bool` | `false` | no |
| oidc\_github\_repos | GitHub repository names in org/repo format allowed to assume the OIDC role. The first entry is also used as the repository tag on the IAM role. | `list(string)` | `[]` | no |
| oidc\_provider\_exists | Set to true if the GitHub OIDC provider already exists in the account. | `bool` | `true` | no |
| oidc\_thumbprint\_list | Custom thumbprint list for the OIDC provider (leave empty to auto-fetch). | `list(string)` | `[]` | no |
| path | The path to the role. | `string` | `"/"` | no |
| permissions\_boundary | The ARN of the policy that is used to set the permissions boundary for the role. | `string` | `""` | no |
| policy | The policy document. | `string` | `null` | no |
| policy\_arn | The ARN of the policy you want to apply. | `string` | `""` | no |
| policy\_arns | List of IAM managed policy ARNs to attach to the OIDC role. | `list(string)` | `[]` | no |
| policy\_enabled | Whether to Attach Iam policy with role. | `bool` | `false` | no |
| provider\_url | The URL of the GitHub OIDC identity provider. | `string` | `""` | no |
| repository | https://github.com/clouddrove/terraform-aws-iam-role | `string` | `""` | no |
| tags | Additional tags to apply to all resources managed by the module (merged with module.labels.tags via extra\_tags). | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | Module      : Iam Role Description : Terraform module to create Iam Role resource on AWS. |
| name | Name of specifying the role. |
| oidc\_role\_arn | The ARN of the GitHub OIDC IAM role. |
| oidc\_role\_tags | Tags applied to the GitHub OIDC IAM role. |
| policy | The policy document attached to the role. |
| role | The name of the role associated with the policy. |
| tags | A mapping of tags to assign to the resource. |

