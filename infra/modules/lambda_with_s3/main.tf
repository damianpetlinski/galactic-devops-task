resource "aws_iam_role" "lambda_exec" {
  name = "lambda-exec-role-${var.lambda_function_name}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = {
        Service = "lambda.amazonaws.com"
      }
    }]
  })

  tags = var.tags
}

resource "aws_iam_policy_attachment" "lambda_basic" {
  name       = "lambda-basic-${var.lambda_function_name}"
  roles      = [aws_iam_role.lambda_exec.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_s3_bucket" "this" {
  bucket        = var.s3_bucket_name
  force_destroy = var.s3_force_destroy
  tags          = var.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = var.s3_kms_key_id != "" ? var.s3_kms_key_id : null
      sse_algorithm     = var.s3_kms_key_id != "" ? "aws:kms" : "AES256"

    }
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  count = var.s3_enable_public_access_block ? 1 : 0
  bucket = aws_s3_bucket.this.id

  block_public_acls       = var.s3_block_public_acls
  block_public_policy     = var.s3_block_public_policy
  ignore_public_acls      = var.s3_ignore_public_acls
  restrict_public_buckets = var.s3_restrict_public_buckets
}


resource "aws_lambda_function" "this" {
  function_name = var.lambda_function_name
  role          = aws_iam_role.lambda_exec.arn
  handler       = var.handler
  runtime       = var.runtime
  filename      = var.deployment_package_path
  timeout       = var.timeout
  memory_size   = var.memory_size

  vpc_config {
    subnet_ids         = var.vpc_config.subnet_ids
    security_group_ids = var.vpc_config.security_group_ids
  }

  environment {
    variables = merge(
      var.environment_variables
    )
  }

  depends_on = [aws_iam_policy_attachment.lambda_basic]
  tags       = var.tags
}
