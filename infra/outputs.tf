output "api_gateway_invoke_url" {
  value = module.apigw.invoke_url
}

output "lambda_function_name" {
  value = module.lambda_with_s3.lambda_function_name
}

output "rds_endpoint" {
  value = module.rds.db_address
}

output "s3_bucket_name" {
  value = module.lambda_with_s3.lambda_s3_bucket_name
}
