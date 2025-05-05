variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "runtime" {
  description = "Runtime for Lambda"
  type        = string
  default     = "python3.11"
}

variable "handler" {
  description = "Lambda handler"
  type        = string
  default     = "main.lambda_handler"
}

variable "deployment_package_path" {
  description = "Path to the ZIP file for Lambda deployment"
  type        = string
}

variable "timeout" {
  description = "Lambda timeout in seconds"
  type        = number
  default     = 30
}

variable "memory_size" {
  description = "Amount of memory for Lambda in MB"
  type        = number
  default     = 512
}

variable "vpc_config" {
  description = "VPC configuration for Lambda"
  type = object({
    subnet_ids         = list(string)
    security_group_ids = list(string)
  })
}

variable "environment_variables" {
  description = "Key-value pairs for Lambda environment variables"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}

variable "s3_bucket_name" {
  description = "Name of the S3 bucket to create"
  type        = string
}

variable "s3_force_destroy" {
  description = "Force destroy the S3 bucket when removing"
  type        = bool
  default     = true
}

variable "s3_kms_key_id" {
  description = "KMS Key ID to use for S3 server-side encryption"
  type        = string
  default     = ""
}

variable "s3_block_public_acls" {
  description = "Block public ACLs"
  type        = bool
  default     = true
}

variable "s3_block_public_policy" {
  description = "Block public bucket policies"
  type        = bool
  default     = true
}

variable "s3_ignore_public_acls" {
  description = "Ignore public ACLs"
  type        = bool
  default     = true
}

variable "s3_restrict_public_buckets" {
  description = "Restrict public buckets"
  type        = bool
  default     = true
}

variable "s3_enable_public_access_block" {
  description = "Whether to create public access block resource"
  type        = bool
  default     = true
}
