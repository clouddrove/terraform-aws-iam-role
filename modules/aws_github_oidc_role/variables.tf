variable "name" {
  type        = string
  description = "Name for tags"
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-control-tower.git"
  description = "Repository name for tags"
}

variable "environment" {
  type        = string
  description = "Environment name for tags"
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "Managed by for tags"
}

variable "provider_url" {
  type        = string
  description = "URL for the OIDC provider"
}

variable "oidc_github_repos" {
  type        = list(string)
  description = "GitHub repository names for access"
}

variable "role_name" {
  type        = string
  description = "Name of the AWS IAM Role to create"
}

variable "enable" {
  type        = bool
  default     = true
  description = "Create aws oidc GitHUb role or not"
}

variable "oidc_provider_exists" {
  type        = bool
  default     = true
  description = "Mention oidc provider exist or not in true or false"
}

variable "policy_arns" {
  type        = list(string)
  description = "A list of ARNs of policies to attach to the IAM role."
}