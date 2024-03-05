output "arn" {
  description = "The ARN assigned by AWS for this provider"
  value       = aws_iam_role.github[*].arn
}

output "tags" {
  description = "The gets tags provided for role"
  value       = module.labels.tags
}