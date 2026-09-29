output "provider_arn" {
  description = "The ARN assigned by AWS for this provider"
  value       = module.aws_github_oidc_role.oidc_role_arn
}

output "tags" {
  description = "The gets tags provided for role"
  value       = module.aws_github_oidc_role.oidc_role_tags
}

output "role_arn" {
  description = "The ARN of the IAM role created with custom policies"
  value       = module.aws_github_oidc_role_custom_policy.oidc_role_arn
}

output "role_tags" {
  description = "The tags assigned to the custom policy IAM role"
  value       = module.aws_github_oidc_role_custom_policy.oidc_role_tags
}
