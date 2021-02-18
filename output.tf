output "db_name" {
  value       = aws_db_instance.main.name
  description = "The name of the database."
}

output "db_username" {
  value       = aws_db_instance.main.username
  description = "The username for the database."
}

output "db_port" {
  value       = aws_db_instance.main.port
  description = "The port the database is running on."
}

output "db_endpoint" {
  value       = aws_db_instance.main.endpoint
  description = "The endpoint of the database."
}