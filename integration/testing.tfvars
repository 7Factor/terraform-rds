vpc_id = "vpc-0ba52c8515274079b"
primary_db_subnets = ["subnet-02fa48e5529e4c681", "subnet-0a5114ad33c1b308e"]
additional_db_subnet_config = [
  {
    az   = "us-east-1c"
    cidr = "172.0.98.0/24"
  }, {
    az   = "us-east-1d"
    cidr = "172.0.99.0/24"
  }
]
allow_db_access_sgs = ["sg-058c16fff68126a2c"]
db_name         = "integrationtestrds"
db_size         = 100
db_storage_type = "gp2"
db_engine       = "postgres"

db_engine_version   = "11.5"
db_instance_class   = "db.t2.micro"
db_username         = "integrationtestuser"
db_password         = "password"
db_port             = 5432

skip_final_snapshot = true
