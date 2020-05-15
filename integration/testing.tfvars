vpc_id = "vpc-0e6ce80c5861c0584"
primary_db_subnets = ["subnet-082ac19a5e55f8736", "subnet-0830c1406c1904fa4"]
additional_db_subnet_config = [
  {
    az   = "us-east-1c"
    cidr = "172.0.98.0/24"
  }, {
    az   = "us-east-1d"
    cidr = "172.0.99.0/24"
  }
]
allow_db_access_sgs = ["sg-0f5e9af5c86036b9f"]
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
