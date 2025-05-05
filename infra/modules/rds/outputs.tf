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
