# 500_database

output "sql_server_name" {
  value = module.sql_server.server_name
}

output "sql_master_database_name" {
  value = module.sql_server.sql_master_database_name
}

output "sql_pepsi_database_name" {
  value = module.sql_database_pepsi.name
}

output "sql_lowes_database_name" {
  value = module.sql_database_lowes.name
}

output "sql_adm_database_name" {
  value = module.sql_database_adm.name
}