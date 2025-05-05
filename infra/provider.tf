provider "aws" {
  region                      = var.aws_region
  access_key                  = var.aws_access_key_id
  secret_key                  = var.aws_secret_access_key
  skip_credentials_validation = local.is_local
  skip_metadata_api_check     = local.is_local
  skip_requesting_account_id  = local.is_local
  s3_use_path_style           = local.is_local

  endpoints {
    s3         = local.is_local ? var.aws_endpoint_url : null
    iam        = local.is_local ? var.aws_endpoint_url : null
    lambda     = local.is_local ? var.aws_endpoint_url : null
    apigateway = local.is_local ? var.aws_endpoint_url : null
    sts        = local.is_local ? var.aws_endpoint_url : null
    ec2        = local.is_local ? var.aws_endpoint_url : null
    rds        = local.is_local ? var.aws_endpoint_url : null
  }
}
