##-----------------------------------------------------------------------------
## Labels module callled that will be used for naming and tags.
##-----------------------------------------------------------------------------
module "labels" {
  source  = "clouddrove/labels/aws"
  version = "1.3.1"

  enabled     = var.enabled
  name        = var.name
  repository  = var.repository
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
  extra_tags  = var.tags
}

locals {
  # user supplied OIDC settings -> this module call is meant for GitHub OIDC
  oidc_configured = var.provider_url != ""

  # GitHub OIDC role + provider + policies
  create_oidc = var.enabled && var.oidc_enabled

  # normal IAM role: only when this is NOT an OIDC call
  create_role = var.enabled && !var.oidc_enabled && !local.oidc_configured
}

##-----------------------------------------------------------------------------
## Below resource will deploy IAM role in AWS environment.
##-----------------------------------------------------------------------------
resource "aws_iam_role" "default" {
  count                 = local.create_role ? 1 : 0
  name                  = module.labels.id
  assume_role_policy    = coalesce(var.assume_role_policy, data.aws_iam_policy_document.default_assume_role[0].json)
  force_detach_policies = var.force_detach_policies
  path                  = var.path
  description           = var.description
  max_session_duration  = var.max_session_duration
  permissions_boundary  = var.permissions_boundary
  tags                  = module.labels.tags
}

##-----------------------------------------------------------------------------
## GitHub OIDC role — delegated to the internal sub-module when oidc_enabled.
##-----------------------------------------------------------------------------
module "github_oidc_role" {
  source = "./modules/aws_github_oidc_role"
  count  = local.create_oidc ? 1 : 0

  name                      = var.name
  environment               = var.environment
  managedby                 = var.managedby
  label_order               = var.label_order
  provider_url              = var.provider_url
  oidc_provider_exists      = var.oidc_provider_exists
  oidc_github_repos         = var.oidc_github_repos
  policy_arns               = var.policy_arns
  oidc_thumbprint_list      = var.oidc_thumbprint_list
  custom_assume_role_policy = var.custom_assume_role_policy
}

##-----------------------------------------------------------------------------
## Below resource will deploy IAM policy and attach it to above created IAM role.
##-----------------------------------------------------------------------------
resource "aws_iam_role_policy" "default" {
  count  = local.create_role && var.policy_enabled && var.policy_arn == "" ? 1 : 0
  name   = format("%s-policy", module.labels.id)
  role   = aws_iam_role.default[0].id
  policy = var.policy
}

##-----------------------------------------------------------------------------
## Below resource will attach IAM policy to above created IAM role.
##-----------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "default" {
  count      = local.create_role && var.policy_enabled && var.policy_arn != "" ? 1 : 0
  role       = aws_iam_role.default[0].id
  policy_arn = var.policy_arn
}

##-----------------------------------------------------------------------------
## Below resource will attach managed policies arn to IAM role
##-----------------------------------------------------------------------------
resource "aws_iam_role_policy_attachment" "managed_policy" {
  for_each   = local.create_role ? toset(var.managed_policy_arns) : []
  role       = aws_iam_role.default[0].id
  policy_arn = each.value
}
