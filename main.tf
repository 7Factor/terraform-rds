terraform {
  required_version = ">=0.12.3"
}

# Look up the primary VPC
data "aws_vpc" "primary_vpc" {
  id = var.vpc_id
}

resource "aws_db_instance" "main" {
  allocated_storage         = var.db_size
  storage_type              = var.db_storage_type
  final_snapshot_identifier = "${var.db_name}-final-snapshot"
  skip_final_snapshot       = var.skip_final_snapshot

  engine              = var.db_engine
  identifier          = var.db_name
  name                = var.db_name
  publicly_accessible = false

  vpc_security_group_ids = flatten([
    aws_security_group.allow_rds_access.id,
    var.allow_db_access_sgs,
  ])
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name

  engine_version = var.db_engine_version
  instance_class = var.db_instance_class
  username       = var.db_username
  password       = var.db_password
  port           = var.db_port
}
