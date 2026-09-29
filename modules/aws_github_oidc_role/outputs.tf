output "arn" {
  description = "The ARN of the IAM role"
  value       = aws_iam_role.github.arn
}

output "tags" {
  description = "The gets tags provided for role"
  value       = module.labels.tags
}
