## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| assume\_role\_policy | Whether to create Iam role. | `string` | `null` | no |
| description | The description of the role. | `string` | `""` | no |
| enabled | Whether to create Iam role. | `bool` | `true` | no |
| environment | Environment (e.g. `prod`, `dev`, `staging`). | `string` | `""` | no |
| force\_detach\_policies | The policy that grants an entity permission to assume the role. | `bool` | `false` | no |
| label\_order | Label order, e.g. `name`,`application`. | `list(any)` | <pre>[<br>  "name",<br>  "environment"<br>]</pre> | no |
| managed\_policy\_arns | Set of exclusive IAM managed policy ARNs to attach to the IAM role | `list(any)` | `[]` | no |
| managedby | ManagedBy, eg 'CloudDrove' | `string` | `"hello@clouddrove.com"` | no |
| max\_session\_duration | The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours. | `number` | `3600` | no |
| name | Name  (e.g. `app` or `cluster`). | `string` | `""` | no |
| path | The path to the role. | `string` | `"/"` | no |
| permissions\_boundary | The ARN of the policy that is used to set the permissions boundary for the role. | `string` | `""` | no |
| policy | The policy document. | `string` | `null` | no |
| policy\_arn | The ARN of the policy you want to apply. | `string` | `""` | no |
| policy\_enabled | Whether to Attach Iam policy with role. | `bool` | `false` | no |
| repository | https://github.com/clouddrove/terraform-aws-iam-role | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| arn | The Amazon Resource Name (ARN) specifying the role. |
| name | Name of specifying the role. |
| policy | The policy document attached to the role. |
| role | The name of the role associated with the policy. |
| tags | A mapping of tags to assign to the resource. |
