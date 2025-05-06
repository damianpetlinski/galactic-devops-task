locals {
  is_local    = var.provider_type == "local"
  invoke_url  = local.is_local ? "http://localhost:4566/restapis/${aws_api_gateway_rest_api.this.id}/${var.environment}/_user_request_" : "https://${aws_api_gateway_rest_api.this.id}.execute-api.${data.aws_region.current.name}.amazonaws.com/${var.environment}"
}
