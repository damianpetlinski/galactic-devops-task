variable "identifier" {
  description = "Identifier for the RDS instance"
  type        = string
}

variable "engine" {
  type        = string
  default     = "postgres"
}

variable "engine_version" {
  type        = string
  default     = "15.4"
}

variable "instance_class" {
  type        = string
  default     = "db.t3.micro"
}

variable "username" {
  type = string
}

variable "password" {
  type      = string
  sensitive = true
}

variable "db_name" {
  type    = string
  default = "users"
}

variable "port" {
  type    = number
  default = 5432
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "vpc_security_group_ids" {
  description = "If not creating a new SG, supply existing SG IDs"
  type        = list(string)
  default     = []
}

variable "allowed_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "source_security_group_ids" {
  type    = list(string)
  default = []
}

variable "create_security_group" {
  type    = bool
  default = true
}

variable "allocated_storage" {
  type    = number
  default = 20
}

variable "max_allocated_storage" {
  type    = number
  default = 100
}

variable "storage_encrypted" {
  type    = bool
  default = true
}

variable "kms_key_id" {
  type    = string
  default = ""
}

variable "skip_final_snapshot" {
  type    = bool
  default = true
}

variable "deletion_protection" {
  type    = bool
  default = false
}

variable "backup_retention_period" {
  type    = number
  default = 7
}

variable "backup_window" {
  type    = string
  default = "03:00-04:00"
}

variable "maintenance_window" {
  type    = string
  default = "Sun:05:00-Sun:06:00"
}

variable "publicly_accessible" {
  type    = bool
  default = false
}

variable "apply_immediately" {
  type    = bool
  default = true
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "store_credentials_in_secretsmanager" {
  type        = bool
  default     = false
  description = "Store credentials in Secrets Manager"
}
