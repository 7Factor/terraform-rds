resource "aws_db_subnet_group" "rds_subnet_group" {
  name = "${var.db_name}-rds-subnet-group"

  subnet_ids = [
    "${aws_subnet.db_subnets.*.id}",
    "${var.primary_db_subnets}",
  ]

  tags {
    Name = "RDS Subnet Group for ${var.db_name}"
  }
}

resource "aws_subnet" "db_subnets" {
  vpc_id            = "${data.aws_vpc.primary_vpc.id}"
  count             = "${length(var.additional_db_subnet_config)}"
  cidr_block        = "${lookup(var.additional_db_subnet_config[count.index], "cidr")}"
  availability_zone = "${lookup(var.additional_db_subnet_config[count.index], "az")}"

  tags {
    Name = "Private Subnet (${lookup(var.additional_db_subnet_config[count.index], "az")})"
  }
}

resource "aws_security_group" "allow_rds_access" {
  name        = "allow-${var.db_name}-access"
  description = "Allow access to the ${var.db_name} instance."
  vpc_id      = "${var.vpc_id}"

  ingress {
    from_port       = "${var.db_port}"
    to_port         = "${var.db_port}"
    protocol        = "TCP"
    security_groups = "${var.allow_db_access_sgs}"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "Allow ${var.db_name} Access"
  }
}
