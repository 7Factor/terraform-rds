vpc_id = "VPC-ID"

# Private subnet for databases
primary_db_subnets = [
  {
    az   = "us-east-1c"
    cidr = "172.0.4.0/24"
    }, {
    az   = "us-east-1d"
    cidr = "172.0.5.0/24"
  }
]

db_name         = "THE-NAME"
db_size         = 100
db_storage_type = "gp2"
db_engine       = "postgres"

db_engine_version   = ""
allow_db_access_sgs = ["SG-1", "SG-2"]
db_instance_class   = "db.t2.micro"
db_username         = "dude"
db_password         = "DON'T PUT THIS IN HERE"
db_port             = 5432