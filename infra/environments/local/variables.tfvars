# --- ENV / AWS ---
environment           = "local"
aws_region            = "us-east-1"
aws_endpoint_url      = "http://localhost:4566"
aws_access_key_id     = "test"
aws_secret_access_key = "test"
provider_type         = "local"       
# --- TAGS ---
tags = {
  Project     = "user-api"
  Environment = "local"
  Owner       = "damian"
}

# --- NETWORKING ---
vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["us-east-1a", "us-east-1b"]
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.11.0/24", "10.0.12.0/24"]
enable_nat_gateway   = true

# --- RDS ---
db_identifier            = "users-db"
db_engine                = "postgres"
db_engine_version        = "15.4"
db_instance_class        = "db.t3.micro"
db_username              = "postgres"
db_password              = "postgres"
db_name                  = "users"
db_allocated_storage     = 20
db_max_allocated_storage = 100
db_skip_final_snapshot   = true
db_deletion_protection   = false
db_backup_retention_period = 7
db_backup_window         = "03:00-04:00"
db_maintenance_window    = "Sun:05:00-Sun:06:00"

# --- LAMBDA ---
lambda_function_name    = "user-api-fn"
lambda_runtime          = "python3.11"
lambda_handler          = "main.lambda_handler"
lambda_package_path     = "../lambda_package/lambda.zip"
lambda_timeout          = 30
lambda_memory_size      = 512

s3_bucket_name                 = "user-api-dev-bucket"
s3_force_destroy              = true
s3_kms_key_id                 = ""
s3_block_public_acls          = true
s3_block_public_policy        = true
s3_ignore_public_acls         = true
s3_restrict_public_buckets    = true
s3_enable_public_access_block = true

# --- API GATEWAY ---
api_name         = "user-api"
api_description  = "API Gateway for user service"
api_resources    = ["users", "healthcheck", "populate"]
api_http_method  = "ANY"
api_authorization = "NONE"
api_key_required = false
