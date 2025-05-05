###################################
# main.tf
###################################

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
    for_each = var.source_security_group_ids != null && length(var.source_security_group_ids) > 0 ? var.source_security_group_ids : []
    content {
      from_port                = var.port
      to_port                  = var.port
      protocol                 = "tcp"
      security_groups          = [ingress.value]
    }
  }

  dynamic "ingress" {
    for_each = var.allowed_cidr_blocks != null && length(var.allowed_cidr_blocks) > 0 ? var.allowed_cidr_blocks : []
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

resource "aws_db_instance" "this" {
  identifier              = var.identifier
  engine                  = var.engine
  engine_version          = var.engine_version
  instance_class          = var.instance_class
  username                = var.username
  password                = var.password
  db_name                 = var.db_name
  db_subnet_group_name    = aws_db_subnet_group.this.name
  vpc_security_group_ids  = var.create_security_group ? [aws_security_group.this[0].id] : var.vpc_security_group_ids
  allocated_storage       = var.allocated_storage
  max_allocated_storage   = var.max_allocated_storage
  storage_encrypted       = var.storage_encrypted
  kms_key_id              = var.kms_key_id != "" ? var.kms_key_id : null
  skip_final_snapshot     = var.skip_final_snapshot
  deletion_protection     = var.deletion_protection
  backup_retention_period = var.backup_retention_period
  backup_window           = var.backup_window
  maintenance_window      = var.maintenance_window
  publicly_accessible     = var.publicly_accessible
  apply_immediately       = var.apply_immediately
  tags                    = var.tags
}
