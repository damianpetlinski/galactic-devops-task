resource "aws_api_gateway_rest_api" "this" {
  name        = var.name
  description = var.description

  endpoint_configuration {
    types = ["REGIONAL"]
  }

  tags = var.tags
}

resource "aws_api_gateway_resource" "resource" {
  for_each    = toset(var.resources)
  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = each.value
}

resource "aws_api_gateway_method" "method" {
  for_each         = toset(var.resources)
  rest_api_id      = aws_api_gateway_rest_api.this.id
  resource_id      = aws_api_gateway_resource.resource[each.value].id
  http_method      = var.method
  authorization    = var.authorization
  api_key_required = var.api_key_required
}

resource "aws_api_gateway_integration" "integration" {
  for_each                = toset(var.resources)
  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.resource[each.value].id
  http_method             = aws_api_gateway_method.method[each.value].http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.lambda_uri
}

resource "aws_api_gateway_deployment" "deployment" {
  depends_on  = [aws_api_gateway_integration.integration]
  rest_api_id = aws_api_gateway_rest_api.this.id
  triggers = {
    redeploy = timestamp()
  }
}

resource "aws_lambda_permission" "apigw" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = var.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_api_gateway_rest_api.this.execution_arn}/${var.stage_name}/*"
}
