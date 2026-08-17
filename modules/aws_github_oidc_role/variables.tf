#Module      : LABEL
#Description : Terraform label module variables

variable "name" {
  type        = string
  default     = ""
  description = "Name for tags. Also used to derive the IAM role name via the labels module when `role_name` is not set."
}

variable "repository" {
  type        = string
  default     = "https://github.com/clouddrove/terraform-aws-iam-role.git"
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

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`application`."
}

#Module      : OIDC
#Description : Terraform github oidc module variables

variable "provider_url" {
  type        = string
  description = "The URL of the identity provider for the OIDC"
}

variable "custom_assume_role_policy" {
  type        = string
  default     = ""
  description = "The custom json trusted_policy for attached to the role"
}

variable "oidc_github_repos" {
  type        = list(string)
  description = "GitHub repository names for access"
}

variable "role_name" {
  type        = string
  default     = ""
  description = "Explicit name for the IAM role. If not set, falls back to the label-derived name from `name` (via the labels module)."
}

variable "oidc_provider_exists" {
  type        = bool
  default     = true
  description = "Mention oidc provider exist or not in true or false"
}

variable "policy_arns" {
  type        = list(string)
  description = "A list of policies/permissions to attach to the IAM role."
}

variable "oidc_thumbprint_list" {
  description = "Custom thumbprint list for OIDC provider"
  type        = list(string)
  default     = []
}

