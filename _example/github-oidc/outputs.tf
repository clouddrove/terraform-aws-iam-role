output "name" {
  value       = module.aws_github_oidc_role
  description = "Name of the role."
}

output "arn" {
  value       = module.aws_github_oidc_role
  description = "The Amazon Resource Name (ARN) specifying the role."
}

output "tags" {
  value       = module.aws_github_oidc_role
  description = "A mapping of tags to assign to the resource."
}
