# Base variable requirements
variable "vpc_id" {
  description = "The ID of the VPC that we want to install things into."
}

# Database configuration
variable "primary_db_subnets" {
  type        = list(string)
  description = "A list a subnets to place your databases in. These should be private."
}

variable "additional_db_subnet_config" {
  type        = list(string)
  default     = []
  description = "An optional list of maps that describe the additional db subnets you want to create for the RDS. Make sure these don't collide with your primary subnets."
}

variable "db_name" {
  description = "The name of the database to create."
}

variable "db_size" {
  description = "The size of the database (in GB) to provision."
}

variable "db_storage_type" {
  description = "The storage type for the database to create."
}

variable "db_engine" {
  description = "Database engine to use. No default since we make no assumptions here."
}

variable "db_engine_version" {
  description = "The version of the databse to use. This is coupled to the engine type."
}

variable "allow_db_access_sgs" {
  type        = list(string)
  default     = []
  description = "Pass in a list of security groups that will have access to your Aurora cluser. Be smart with this."
}

variable "db_instance_class" {
  description = "The instance type to assign to the database."
}

variable "db_username" {
  description = "The username for accessing the database."
}

variable "db_password" {
  description = "The password to access the DB. This is usually a 'master' or 'root' password, so don't be dumb and pass this in as clear text or check it in somewhere."
}

variable "db_port" {
  description = "The port. Like, for the database. And stuff."
}

variable "skip_final_snapshot" {
  default     = false
  description = "If you set this to true, it won't store a backup if the db is deleted. Mostly here for testing."
}
