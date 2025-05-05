output "rest_api_id" {
  value       = aws_api_gateway_rest_api.this.id
  description = "ID of the REST API"
}

output "execution_arn" {
  value       = aws_api_gateway_rest_api.this.execution_arn
  description = "Execution ARN of the REST API"
}

output "invoke_url" {
  description = "Base URL to invoke the API"
  value       = local.invoke_url
}
