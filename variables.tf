#Module      : LABEL
#Description : Terraform label module variables
variable "name" {
  type        = string
  default     = ""
  description = "Name  (e.g. `app` or `cluster`)."
}

variable "repository" {
  type        = string
  default     = ""
  description = "https://github.com/clouddrove/terraform-aws-iam-role"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "label_order" {
  type        = list(any)
  default     = ["name", "environment"]
  description = "Label order, e.g. `name`,`application`."
}

variable "managedby" {
  type        = string
  default     = "hello@clouddrove.com"
  description = "ManagedBy, eg 'CloudDrove'"
}

# Module      : Iam Role
# Description : Terraform Iam Role module variables.
variable "enabled" {
  type        = bool
  default     = true
  description = "Whether to create Iam role."
}

variable "assume_role_policy" {
  description = "Whether to create Iam role."
  sensitive   = true
}

variable "managed_policy_arns" {
  type        = list(any)
  default     = []
  description = "Set of exclusive IAM managed policy ARNs to attach to the IAM role"
}
variable "force_detach_policies" {
  type        = bool
  default     = false
  description = "The policy that grants an entity permission to assume the role."
}

variable "path" {
  type        = string
  default     = "/"
  description = "The path to the role."
}

variable "description" {
  type        = string
  default     = ""
  description = "The description of the role."
}

variable "max_session_duration" {
  type        = number
  default     = 3600
  description = "The maximum session duration (in seconds) that you want to set for the specified role. If you do not specify a value for this setting, the default maximum of one hour is applied. This setting can have a value from 1 hour to 12 hours."
}

variable "permissions_boundary" {
  type        = string
  default     = ""
  description = "The ARN of the policy that is used to set the permissions boundary for the role."
  sensitive   = true
}

variable "policy" {
  default     = null
  description = "The policy document."
  sensitive   = true
}

variable "policy_enabled" {
  type        = bool
  default     = false
  description = "Whether to Attach Iam policy with role."
}

variable "policy_arn" {
  type        = string
  default     = ""
  description = "The ARN of the policy you want to apply."
  sensitive   = true
}
