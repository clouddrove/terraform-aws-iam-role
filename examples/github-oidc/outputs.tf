# ################################################################################
# # GitHub OIDC Provider
# ################################################################################

output "provider_arn" {
  description = "The ARN assigned by AWS for this provider"
  value       = module.aws_github_oidc_role.arn
}

output "tags" {
  description = "The gets tags provided for role"
  value       = module.aws_github_oidc_role.tags
}

output "role_arn" {
  value = module.aws_github_oidc_role_custom_policy.arn
}

output "role_tags" {
  value = module.aws_github_oidc_role_custom_policy.tags
}
