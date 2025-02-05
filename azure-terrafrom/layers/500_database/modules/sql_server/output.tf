output "server_id" {
  value = azurerm_mssql_server.sql_server.id
}

output "admin_user" {
  value = azurerm_mssql_server.sql_server.administrator_login
}

output "admin_password" {
  value = azurerm_mssql_server.sql_server.administrator_login_password
}

output "server_name" {
  value = azurerm_mssql_server.sql_server.name
}

output "sql_master_database_name" {
  value = azurerm_mssql_database.sql_database.name
}

output "sql_database_id" {
  value = azurerm_mssql_database.sql_database.id
}