output "name" {
  value       = module.iam-role.*.name
  description = "Name of the role."
}

output "arn" {
  value       = module.iam-role.*.arn
  description = "The Amazon Resource Name (ARN) specifying the role."
}

output "tags" {
  value       = module.iam-role.tags
  description = "A mapping of tags to assign to the resource."
}