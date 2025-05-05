module "networking" {
  source                  = "./modules/networking"
  vpc_cidr                = var.vpc_cidr
  availability_zones      = var.availability_zones
  public_subnet_cidrs     = var.public_subnet_cidrs
  private_subnet_cidrs    = var.private_subnet_cidrs
  enable_nat_gateway      = var.enable_nat_gateway
  tags                    = var.tags
}

module "rds" {
  source                   = "./modules/rds"
  identifier               = var.db_identifier
  engine                   = var.db_engine
  engine_version           = var.db_engine_version
  instance_class           = var.db_instance_class
  username                 = var.db_username
  password                 = var.db_password
  db_name                  = var.db_name
  allocated_storage        = var.db_allocated_storage
  max_allocated_storage    = var.db_max_allocated_storage
  skip_final_snapshot      = var.db_skip_final_snapshot
  deletion_protection      = var.db_deletion_protection
  backup_retention_period  = var.db_backup_retention_period
  backup_window            = var.db_backup_window
  maintenance_window       = var.db_maintenance_window
  subnet_ids               = module.networking.private_subnet_ids
  vpc_id                   = module.networking.vpc_id
  allowed_cidr_blocks      = [module.networking.vpc_cidr]
  create_security_group    = true
  tags                     = var.tags
}

module "lambda_with_s3" {
  source                    = "./modules/lambda_with_s3"
  lambda_function_name      = var.lambda_function_name
  runtime                   = var.lambda_runtime
  handler                   = var.lambda_handler
  deployment_package_path   = var.lambda_package_path
  timeout                   = var.lambda_timeout
  memory_size               = var.lambda_memory_size

  vpc_config = {
    subnet_ids         = module.networking.private_subnet_ids
    security_group_ids = [module.rds.security_group_id]
  }

  environment_variables = {
    DATABASE_URL = "postgresql://${var.db_username}:${var.db_password}@${module.rds.db_address}:${module.rds.db_port}/${var.db_name}"
    ENVIRONMENT  = var.environment
  }

  s3_bucket_name                 = var.s3_bucket_name
  s3_force_destroy              = var.s3_force_destroy
  s3_kms_key_id                 = var.s3_kms_key_id
  s3_block_public_acls          = var.s3_block_public_acls
  s3_block_public_policy        = var.s3_block_public_policy
  s3_ignore_public_acls         = var.s3_ignore_public_acls
  s3_restrict_public_buckets    = var.s3_restrict_public_buckets
  s3_enable_public_access_block = var.s3_enable_public_access_block

  tags = var.tags
}

module "apigw" {
  source               = "./modules/apigw"
  name                 = var.api_name
  description          = var.api_description
  resources            = var.api_resources
  method               = var.api_http_method
  authorization        = var.api_authorization
  api_key_required     = var.api_key_required
  lambda_uri           = module.lambda_with_s3.lambda_function_arn
  lambda_function_name = module.lambda_with_s3.lambda_function_name
  stage_name           = var.environment
  tags                 = var.tags
  provider_type        = var.provider_type
}
