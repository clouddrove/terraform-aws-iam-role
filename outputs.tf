# Module      : Iam Role
# Description : Terraform module to create Iam Role resource on AWS.
output "arn" {
  value       = join(",", aws_iam_role.default[*].arn)
  description = "The Amazon Resource Name (ARN) specifying the role."
}

output "tags" {
  value       = module.labels.tags
  description = "A mapping of tags to assign to the resource."
}

output "name" {
  value       = join(",", aws_iam_role.default[*].name)
  description = "Name of specifying the role."
}

output "policy" {
  value       = join(",", aws_iam_role_policy.default[*].policy)
  description = "The policy document attached to the role."
}

output "role" {
  value       = join(",", aws_iam_role_policy.default[*].role)
  description = "The name of the role associated with the policy."
}