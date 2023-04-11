output "rds_username" {
  value = aws_db_instance.medium-pg.username
}

output "rds_hostname" {
  value = aws_db_instance.medium-pg.endpoint
}

output "rds_database" {
  value = aws_db_instance.medium-pg.db_name
}