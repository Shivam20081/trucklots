# 500_database

output "sql_server_name" {
  value = module.sql_server.server_name
}

output "sql_lowes_database_name" {
  value = module.sql_database_lowes.name
}

output "sql_master_database_name" {
  value = module.sql_server.sql_master_database_name
}

