variable "name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "description" {
  description = "Description of the API Gateway"
  type        = string
  default     = "API Gateway for Lambda function"
}

variable "resources" {
  description = "List of resource path parts (e.g. [\"users\", \"healthcheck\"])"
  type        = list(string)
}

variable "http_method" {
  description = "HTTP method to allow"
  type        = string
  default     = "GET"
}

variable "authorization" {
  description = "Authorization method (NONE, AWS_IAM, CUSTOM, COGNITO_USER_POOLS)"
  type        = string
  default     = "NONE"
}

variable "api_key_required" {
  description = "Whether API key is required"
  type        = bool
  default     = false
}

variable "lambda_uri" {
  description = "The URI of the Lambda function for integration"
  type        = string
}

variable "lambda_function_name" {
  description = "The Lambda function name (used for permission resource)"
  type        = string
}

variable "stage_name" {
  description = "Deployment stage name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "endpoint_types" {
  description = "List of endpoint types for the API Gateway"
  type        = list(string)
  default     = ["REGIONAL"]
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
