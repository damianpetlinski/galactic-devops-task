variable "name" {
  description = "Name of the API Gateway"
  type        = string
}

variable "description" {
  description = "Description of the API Gateway"
  type        = string
  default     = ""
}

variable "resources" {
  description = "List of resource path parts (e.g. [\"users\", \"healthcheck\"])"
  type        = list(string)
}

variable "method" {
  description = "HTTP method to support"
  type        = string
  default     = "GET"
}

variable "authorization" {
  description = "Authorization type"
  type        = string
  default     = "NONE"
}

variable "api_key_required" {
  description = "Whether an API key is required"
  type        = bool
  default     = false
}

variable "lambda_uri" {
  description = "URI of the Lambda function"
  type        = string
}

variable "lambda_function_name" {
  description = "Name of the Lambda function"
  type        = string
}

variable "stage_name" {
  description = "Deployment stage name"
  type        = string
  default     = "dev"
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}

variable "provider_type" {
  description = "Deployment provider type: local or aws"
  type        = string
}
