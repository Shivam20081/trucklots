resource "azurerm_mssql_database" "sql_database" {
  name                        = "GS-sql-database-${var.Env}-${var.tenant_name}"
  server_id                   = var.server_id
  collation                   = "SQL_Latin1_General_CP1_CI_AS"
  max_size_gb                 = var.storage
  sku_name                    = var.sql_db_sku
  min_capacity                = "0.5"
  geo_backup_enabled          = true
  auto_pause_delay_in_minutes = local.auto_pause

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
    AppSuite = var.tenant_name
  }
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
    command = "python add_users.py ${var.rg_name} ${var.server_name} ${var.server_username} ${var.server_password} GS-sql-database-${var.Env}-${var.tenant_name} gs_sql_dbuser_${var.Env}_${var.tenant_name}_appuser ${random_password.password1.result} gs_sql_dbuser_${var.Env}_${var.tenant_name}_teamuser ${random_password.password2.result}"
  }

  depends_on = [ random_password.password1, random_password.password2, azurerm_mssql_database.sql_database ]
}

resource "azurerm_key_vault_secret" "appuser_username" {
  name         = "sql-${var.Env}-${var.tenant_name}-appuser-username"
  value        = "gs_sql_dbuser_${var.Env}_${var.tenant_name}_appuser"
  key_vault_id = var.key_vault_id

  depends_on = [ null_resource.run_python_script ]
}

resource "azurerm_key_vault_secret" "appuser_password" {
  name         = "sql-${var.Env}-${var.tenant_name}-appuser-password"
  value        = random_password.password1.result
  key_vault_id = var.key_vault_id

  depends_on = [ null_resource.run_python_script ]
}

resource "azurerm_key_vault_secret" "teamuser_username" {
  name         = "sql-${var.Env}-${var.tenant_name}-teamuser-username"
  value        = "gs_sql_dbuser_${var.Env}_${var.tenant_name}_teamuser"
  key_vault_id = var.key_vault_id

  depends_on = [ null_resource.run_python_script ]
}

resource "azurerm_key_vault_secret" "teamuser_password" {
  name         = "sql-${var.Env}-${var.tenant_name}-teamuser-password"
  value        = random_password.password2.result
  key_vault_id = var.key_vault_id

  depends_on = [ null_resource.run_python_script ]
}