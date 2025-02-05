resource "azurerm_mssql_server" "sql_server" {
  name                         = "gs-sql-sqlserver-${var.Env}-eastus-${var.counts}"
  resource_group_name          = var.rg_name
  location                     = var.rg_location
  version                      = "12.0"
  administrator_login          = "gs-sql-${var.Env}-rootadmin"
  administrator_login_password = random_password.root_password.result

  tags = {
    Env = var.Env
    EnvAcct = local.EnvAcct
    AppSuite = "database"
  }
}

resource "azurerm_mssql_database" "sql_database" {
  name           = "GS-sql-database-${var.Env}-master"
  server_id      = azurerm_mssql_server.sql_server.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  max_size_gb    = var.storage
  sku_name       = var.sql_db_sku
  geo_backup_enabled = true

  short_term_retention_policy  {
    retention_days = 7
  }

  dynamic "long_term_retention_policy" {
    for_each = var.ltrp == true ? [1] : []
    
    content {
      monthly_retention = "P12M"
      yearly_retention  = "P10Y"
      weekly_retention  = "P12W"
      week_of_year      = 1
    }
  }
  
  tags = {
    Env = var.Env
    EnvAcct = local.EnvAcct
    AppSuite = "master"
  }
}


resource "random_password" "root_password" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "azurerm_key_vault_secret" "root_password" {
  name         = "sql-server-${var.Env}-root-password"
  value        = random_password.root_password.result
  key_vault_id = var.key_vault_id

  depends_on = [ azurerm_mssql_server.sql_server ]
}

resource "azurerm_key_vault_secret" "root_username" {
  name         = "sql-server-${var.Env}-root-username"
  value        = "gs-sql-${var.Env}-rootadmin"
  key_vault_id = var.key_vault_id

  depends_on = [ azurerm_mssql_server.sql_server ]
}

resource "random_password" "password1" {
  length           = 16
  special          = true
  override_special = "_%@"
}

resource "random_password" "password2" {
  length           = 16
  special          = true
  override_special = "_%@"
}


resource "null_resource" "run_python_script" {


  provisioner "local-exec" {
    command = "python add_users.py ${var.rg_name} ${azurerm_mssql_server.sql_server.name} ${azurerm_mssql_server.sql_server.administrator_login} ${azurerm_mssql_server.sql_server.administrator_login_password} GS-sql-database-${var.Env}-master gs_sql_dbuser_${var.Env}_master_appuser ${random_password.password1.result} gs_sql_dbuser_${var.Env}_master_teamuser ${random_password.password2.result}"
  }

 
  depends_on = [ random_password.password1, random_password.password2, azurerm_mssql_database.sql_database ]
}

resource "azurerm_key_vault_secret" "appuser_username" {
  name         = "sql-${var.Env}-master-appuser-username"
  value        = "gs_sql_dbuser_${var.Env}_master_appuser"
  key_vault_id = var.key_vault_id
  
  depends_on = [ null_resource.run_python_script ]
}

resource "azurerm_key_vault_secret" "appuser_password" {
  name         = "sql-${var.Env}-master-appuser-password"
  value        = random_password.password1.result
  key_vault_id = var.key_vault_id

  depends_on = [ null_resource.run_python_script ]
}

resource "azurerm_key_vault_secret" "teamuser_username" {
  name         = "sql-${var.Env}-master-teamuser-username"
  value        = "gs_sql_dbuser_${var.Env}_master_teamuser"
  key_vault_id = var.key_vault_id

  depends_on = [ null_resource.run_python_script ]
}

resource "azurerm_key_vault_secret" "teamuser_password" {
  name         = "sql-${var.Env}-master-teamuser-password"
  value        = random_password.password2.result
  key_vault_id = var.key_vault_id

  depends_on = [ null_resource.run_python_script ]
}

resource "azurerm_mssql_firewall_rule" "access" {
  name             = "Access to other Azure Services "
  server_id        = azurerm_mssql_server.sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "0.0.0.0"
}

