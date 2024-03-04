

##-----------------------------------------------------------------------------
## Labels module callled that will be used for naming and tags.   
##-----------------------------------------------------------------------------
module "labels" {
  source  = "clouddrove/labels/aws"
  version = "1.3.0"

  name        = var.name
  repository  = var.repository
  environment = var.environment
  managedby   = var.managedby
  label_order = var.label_order
}

##----------------------------------------------------------------------------- 
## Data block to tls certificate.  
##-----------------------------------------------------------------------------

data "tls_certificate" "github" {
  url = var.provider_url
}

##----------------------------------------------------------------------------- 
## Data block for openid connect provider
##-----------------------------------------------------------------------------

data "aws_iam_openid_connect_provider" "github" {
  count = var.oidc_provider_exists ? 1 : 0
  url   = var.provider_url
}

##-----------------------------------------------------------------------------
## Include iam openid connect provider resource here   
##-----------------------------------------------------------------------------


resource "aws_iam_openid_connect_provider" "github" {
  count           = var.oidc_provider_exists ? 0 : 1
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = var.oidc_provider_exists ? [] : [data.tls_certificate.github.certificates[0].sha1_fingerprint]
  url             = var.provider_url
  tags            = module.labels.tags
}

##-----------------------------------------------------------------------------
## Include the role resource and attachment here
##-----------------------------------------------------------------------------

resource "aws_iam_role" "github" {
  name = var.role_name
  tags = module.labels.tags
  assume_role_policy = var.custom_assume_role_policy != "" ? var.custom_assume_role_policy : jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Principal = {
          Federated = var.oidc_provider_exists ? data.aws_iam_openid_connect_provider.github[0].arn : aws_iam_openid_connect_provider.github[0].arn

        },
        Action = "sts:AssumeRoleWithWebIdentity",
        Condition = {
          StringEquals = {
            "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
          },
          "ForAnyValue:StringLike" = {
            "token.actions.githubusercontent.com:sub" = [
              for repo in var.oidc_github_repos : "repo:${repo}:*"
            ]
          }
        }

      }
    ]
  })
}

##-----------------------------------------------------------------------------
## Include the iam role policy resource attachment here
##-----------------------------------------------------------------------------

resource "aws_iam_role_policy_attachment" "github" {
  count      = length(var.policy_arns)
  role       = aws_iam_role.github.name
  policy_arn = var.policy_arns[count.index]
}