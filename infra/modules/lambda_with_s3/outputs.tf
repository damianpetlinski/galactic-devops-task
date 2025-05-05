output "lambda_function_arn" {
  description = "ARN of the Lambda function"
  value       = aws_lambda_function.this.arn
}

output "lambda_function_name" {
  description = "Name of the Lambda function"
  value       = aws_lambda_function.this.function_name
}

output "s3_bucket_name" {
  description = "Name of the S3 bucket used by Lambda"
  value       = aws_s3_bucket.this.bucket
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.this.arn
}
