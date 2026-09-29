# Module      : Iam Role
# Description : Terraform module to create Iam Role resource on AWS.
output "arn" {
  value = local.create_oidc ? try(module.github_oidc_role[0].arn, "") : try(aws_iam_role.default[0].arn, "")
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

##-----------------------------------------------------------------------------
## GitHub OIDC role outputs (populated only when oidc_enabled = true)
##-----------------------------------------------------------------------------

output "oidc_role_arn" {
  value       = length(module.github_oidc_role) > 0 ? module.github_oidc_role[0].arn : ""
  description = "The ARN of the GitHub OIDC IAM role."
}

output "oidc_role_tags" {
  value       = length(module.github_oidc_role) > 0 ? module.github_oidc_role[0].tags : {}
  description = "Tags applied to the GitHub OIDC IAM role."
}
