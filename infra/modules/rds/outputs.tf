output "db_instance_id" {
  value       = aws_db_instance.this.id
  description = "RDS instance ID"
}

output "db_address" {
  value       = aws_db_instance.this.address
  description = "RDS endpoint address"
}

output "db_port" {
  value       = aws_db_instance.this.port
  description = "RDS port"
}

output "security_group_id" {
  value       = var.create_security_group ? aws_security_group.this[0].id : null
  description = "Security group ID for the RDS instance"
}

output "db_username" {
  value       = var.username
  description = "DB master username"
}

output "db_password" {
  description = "Randomly generated DB password (use only for env vars)"
  value       = var.store_credentials_in_secretsmanager ? random_password.rds_password[0].result : var.password
  sensitive   = true
}

output "secret_arn" {
  description = "ARN of the Secrets Manager secret storing DB credentials"
  value       = var.store_credentials_in_secretsmanager ? aws_secretsmanager_secret.rds_secret[0].arn : null
}
