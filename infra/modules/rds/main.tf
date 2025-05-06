resource "aws_db_subnet_group" "this" {
  name       = var.identifier
  subnet_ids = var.subnet_ids
  tags       = var.tags
}

resource "aws_security_group" "this" {
  count       = var.create_security_group ? 1 : 0
  name        = "rds-sg-${var.identifier}"
  description = "Security group for RDS"
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.source_security_group_ids != null ? var.source_security_group_ids : []
    content {
      from_port       = var.port
      to_port         = var.port
      protocol        = "tcp"
      security_groups = [ingress.value]
    }
  }

  dynamic "ingress" {
    for_each = var.allowed_cidr_blocks != null ? var.allowed_cidr_blocks : []
    content {
      from_port   = var.port
      to_port     = var.port
      protocol    = "tcp"
      cidr_blocks = [ingress.value]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "random_password" "rds_password" {
  count   = var.store_credentials_in_secretsmanager ? 1 : 0
  length  = 16
  special = true
}

resource "aws_secretsmanager_secret" "rds_secret" {
  count       = var.store_credentials_in_secretsmanager ? 1 : 0
  name        = "${var.identifier}-credentials"
  description = "RDS credentials for ${var.identifier}"
}

resource "aws_secretsmanager_secret_version" "rds_secret_version" {
  count        = var.store_credentials_in_secretsmanager ? 1 : 0
  secret_id    = aws_secretsmanager_secret.rds_secret[0].id
  secret_string = jsonencode({
    username = var.username
    password = random_password.rds_password[0].result
  })
}

resource "aws_db_instance" "this" {
  identifier               = var.identifier
  engine                   = var.engine
  engine_version           = var.engine_version
  instance_class           = var.instance_class
  username                 = var.username
  password                 = var.store_credentials_in_secretsmanager ? null : var.password
  allocated_storage        = var.allocated_storage
  max_allocated_storage    = var.max_allocated_storage
  db_name                  = var.db_name
  db_subnet_group_name     = aws_db_subnet_group.this.name
  skip_final_snapshot      = var.skip_final_snapshot
  deletion_protection      = var.deletion_protection
  backup_retention_period  = var.backup_retention_period
  backup_window            = var.backup_window
  maintenance_window       = var.maintenance_window
  storage_encrypted        = true

  vpc_security_group_ids = var.create_security_group ? [aws_security_group.this[0].id] : []

  # Password managed by Secrets Manager if enabled
  manage_master_user_password = var.store_credentials_in_secretsmanager

  tags = var.tags
}
