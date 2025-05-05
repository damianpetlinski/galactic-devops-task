# --- ENVIRONMENT / AWS ---
variable "environment" {
  description = "Deployment environment"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "aws_endpoint_url" {
  description = "AWS endpoint URL (for localstack)"
  type        = string
}

variable "aws_access_key_id" {
  description = "AWS access key"
  type        = string
}

variable "aws_secret_access_key" {
  description = "AWS secret key"
  type        = string
}

variable "provider_type" {
  description = "Type of provider to use (aws | local)"
  type        = string
  default     = ""
}

# --- TAGGING ---
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

# --- NETWORKING ---
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones for subnets"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDRs for public subnets"
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDRs for private subnets"
  type        = list(string)
}

variable "enable_nat_gateway" {
  description = "Whether to deploy a NAT gateway"
  type        = bool
}

# --- RDS ---
variable "db_identifier" {
  type        = string
  description = "RDS identifier"
}

variable "db_engine" {
  type        = string
}

variable "db_engine_version" {
  type        = string
}

variable "db_instance_class" {
  type        = string
}

variable "db_username" {
  type        = string
}

variable "db_password" {
  type        = string
  sensitive   = true
}

variable "db_name" {
  type = string
}

variable "db_allocated_storage" {
  type = number
}

variable "db_max_allocated_storage" {
  type = number
}

variable "db_skip_final_snapshot" {
  type = bool
}

variable "db_deletion_protection" {
  type = bool
}

variable "db_backup_retention_period" {
  type = number
}

variable "db_backup_window" {
  type = string
}

variable "db_maintenance_window" {
  type = string
}

# --- LAMBDA + S3 ---
variable "lambda_function_name" {
  type = string
}

variable "lambda_runtime" {
  type = string
}

variable "lambda_handler" {
  type = string
}

variable "lambda_package_path" {
  type = string
}

variable "lambda_timeout" {
  type = number
}

variable "lambda_memory_size" {
  type = number
}

variable "s3_bucket_name" {
  type = string
}

variable "s3_force_destroy" {
  type = bool
}

variable "s3_kms_key_id" {
  type = string
}

variable "s3_block_public_acls" {
  type = bool
}

variable "s3_block_public_policy" {
  type = bool
}

variable "s3_ignore_public_acls" {
  type = bool
}

variable "s3_restrict_public_buckets" {
  type = bool
}

variable "s3_enable_public_access_block" {
  type = bool
}

# --- API GATEWAY ---
variable "api_name" {
  type = string
}

variable "api_description" {
  type = string
}

variable "api_resources" {
  type = list(string)
}

variable "api_http_method" {
  type = string
}

variable "api_authorization" {
  type = string
}

variable "api_key_required" {
  type = bool
}
