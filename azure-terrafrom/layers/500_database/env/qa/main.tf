# 500_database
module "sql_server" {
  source            = "../../modules/sql_server"
  Env               = var.Env
  counts            = "001"
  rg_name           = var.rg_name
  rg_location       = var.rg_location
  key_vault_id      = data.terraform_remote_state.base.outputs.key_vault_id
  storage           = 50
  sql_db_sku        = "GP_S_Gen5_2"
  ltrp              = false
}

module "office_ip_access1" {
  source              = "../../modules/sql_firewall/ip_based_rule"
  server_id           = module.sql_server.server_id
  firewall_rule_name  =  "Office_IP_1"
  starting_from_ip    = "115.111.242.66"
  ending_ip           = "115.111.242.66"
}

module "office_ip_access2" {
  source              = "../../modules/sql_firewall/ip_based_rule"
  server_id           = module.sql_server.server_id
  firewall_rule_name  =  "Office_IP_2"
  starting_from_ip    = "1.6.8.162"
  ending_ip           = "1.6.8.162"
}

module "sql_endpoint" {
  source            = "../../../../modules/endpoint_module"
  Env               = var.Env
  rg_location       = var.rg_location
  rg_name           = var.rg_name
  subnet_id         = data.terraform_remote_state.base.outputs.private_link_subnet_id
  link_name         = module.sql_server.server_name
  pe_resource_id    = module.sql_server.server_id
  subresource_name  = var.subresource_name
  private_dns_zone_group = false
  
}

module "sql_database_lowes" {
  source            = "../../modules/sql_database"
  sql_db_sku        = "GP_S_Gen5_2"
  storage           = 50
  Env               = var.Env
  server_id         = module.sql_server.server_id
  tenant_name       = "lowes"
  rg_name           = var.rg_name
  server_name       = module.sql_server.server_name
  server_username   = module.sql_server.admin_user
  server_password   = module.sql_server.admin_password
  key_vault_id      = data.terraform_remote_state.base.outputs.key_vault_id
  ltrp              = false

  depends_on        = [ module.sql_server ]
}

module "sql_database_adm" {
  source            = "../../modules/sql_database"
  Env               = var.Env
  sql_db_sku        = "GP_S_Gen5_1"
  storage           = 50
  server_id         = module.sql_server.server_id
  tenant_name       = "adm"
  rg_name           = var.rg_name
  server_name       = module.sql_server.server_name
  server_username   = module.sql_server.admin_user
  server_password   = module.sql_server.admin_password
  key_vault_id      = data.terraform_remote_state.base.outputs.key_vault_id
  ltrp              = false
  
  depends_on        = [ module.sql_server ]
}

module "sql_database_pepsi" {
  source            = "../../modules/sql_database"
  sql_db_sku        = "GP_S_Gen5_2"
  storage           = 50
  Env               = var.Env
  server_id         = module.sql_server.server_id
  tenant_name       = "pepsi"
  rg_name           = var.rg_name
  server_name       = module.sql_server.server_name
  server_username   = module.sql_server.admin_user
  server_password   = module.sql_server.admin_password
  key_vault_id      = data.terraform_remote_state.base.outputs.key_vault_id
  ltrp              = false

  depends_on        = [ module.sql_server ]
}

################################ MONITORING #########################################

module "monitoring_adm" {
  source              = "../../../../modules/diagnostic"
  Env                 = var.Env
  counts              = "003"
  target_id           = module.sql_database_adm.sql_database_id
  storage_account_id  = data.terraform_remote_state.tenant_storage.outputs.storage_account_id
  log_analytics_id    = data.terraform_remote_state.base.outputs.log_analytics_id
}

module "monitoring_lowes" {
  source              = "../../../../modules/diagnostic"
  Env                 = var.Env
  counts              = "004"
  target_id           = module.sql_database_lowes.sql_database_id
  storage_account_id  = data.terraform_remote_state.tenant_storage.outputs.storage_account_id
  log_analytics_id    = data.terraform_remote_state.base.outputs.log_analytics_id
}

module "monitoring_master" {
  source              = "../../../../modules/diagnostic"
  Env                 = var.Env
  counts              = "005"
  target_id           = module.sql_server.sql_database_id
  storage_account_id  = data.terraform_remote_state.tenant_storage.outputs.storage_account_id
  log_analytics_id    = data.terraform_remote_state.base.outputs.log_analytics_id
}

module "monitoring_pepsi" {
  source              = "../../../../modules/diagnostic"
  Env                 = var.Env
  counts              = "006"
  target_id           = module.sql_database_pepsi.sql_database_id
  storage_account_id  = data.terraform_remote_state.tenant_storage.outputs.storage_account_id
  log_analytics_id    = data.terraform_remote_state.base.outputs.log_analytics_id
}

################################### ALERTS ####################################

module "alert_lowes" {
  source            = "../../../../modules/alerts/common_alerts"
  counts            = "001"
  Env               = var.Env
  rg_name           = var.rg_name
  resource_name     = "db-lowes"
  severity          = 2
  resource_id       = module.sql_database_lowes.sql_database_id
  action_group_id   = data.terraform_remote_state.base.outputs.action_group_id
  description       = "CPU utilization is gratter then 80%"
  metric_name       = "cpu_percent"
  metric_namespace  = "Microsoft.Sql/servers/databases"
  aggregation       = "Average"
  threshold         = 80
  operator          = "GreaterThanOrEqual"
}

module "alert_pepsi" {
  source            = "../../../../modules/alerts/common_alerts"
  counts            = "001"
  Env               = var.Env
  rg_name           = var.rg_name
  resource_name     = "db-pepsi"
  severity          = 2
  resource_id       = module.sql_database_pepsi.sql_database_id
  action_group_id   = data.terraform_remote_state.base.outputs.action_group_id
  description       = "CPU utilization is gratter then 80%"
  metric_name       = "cpu_percent"
  metric_namespace  = "Microsoft.Sql/servers/databases"
  aggregation       = "Average"
  threshold         = 80
  operator          = "GreaterThanOrEqual"
}


module "alert_adm" {
  source            = "../../../../modules/alerts/common_alerts"
  counts            = "001"
  Env               = var.Env
  rg_name           = var.rg_name
  resource_name     = "db-adm"
  severity          = 2
  resource_id       = module.sql_database_adm.sql_database_id
  action_group_id   = data.terraform_remote_state.base.outputs.action_group_id
  description       = "CPU utilization is gratter then 80%"
  metric_name       = "cpu_percent"
  metric_namespace  = "Microsoft.Sql/servers/databases"
  aggregation       = "Average"
  threshold         = 80
  operator          = "GreaterThanOrEqual"
}

module "alert_master" {
  source            = "../../../../modules/alerts/common_alerts"
  counts            = "001"
  Env               = var.Env
  rg_name           = var.rg_name
  resource_name     = "db-master"
  severity          = 2
  resource_id       = module.sql_server.sql_database_id
  action_group_id   = data.terraform_remote_state.base.outputs.action_group_id
  description       = "CPU utilization is gratter then 80%"
  metric_name       = "cpu_percent"
  metric_namespace  = "Microsoft.Sql/servers/databases"
  aggregation       = "Average"
  threshold         = 80
  operator          = "GreaterThanOrEqual"
}

module "alert_memory_lowes" {
  source            = "../../../../modules/alerts/common_alerts"
  counts            = "002"
  Env               = var.Env
  rg_name           = var.rg_name
  resource_name     = "db-lowes"
  severity          = 3
  resource_id       = module.sql_database_lowes.sql_database_id
  action_group_id   = data.terraform_remote_state.base.outputs.action_group_id
  description       = "storage percentage is greater than 80%"
  metric_name       = "storage_percent"
  metric_namespace  = "Microsoft.Sql/servers/databases"
  aggregation       = "Average"
  threshold         = 80
  operator          = "GreaterThanOrEqual"
}

module "alert_memory_pepsi" {
  source            = "../../../../modules/alerts/common_alerts"
  counts            = "002"
  Env               = var.Env
  rg_name           = var.rg_name
  resource_name     = "db-pepsi"
  severity          = 3
  resource_id       = module.sql_database_pepsi.sql_database_id
  action_group_id   = data.terraform_remote_state.base.outputs.action_group_id
  description       = "storage percentage is greater than 80%"
  metric_name       = "storage_percent"
  metric_namespace  = "Microsoft.Sql/servers/databases"
  aggregation       = "Average"
  threshold         = 80
  operator          = "GreaterThanOrEqual"
}

module "alert_memory_adm" {
  source            = "../../../../modules/alerts/common_alerts"
  counts            = "002"
  Env               = var.Env
  rg_name           = var.rg_name
  resource_name     = "db-adm"
  severity          = 3
  resource_id       = module.sql_database_adm.sql_database_id
  action_group_id   = data.terraform_remote_state.base.outputs.action_group_id
  description       = "storage percentage is greater than 80%"
  metric_name       = "storage_percent"
  metric_namespace  = "Microsoft.Sql/servers/databases"
  aggregation       = "Average"
  threshold         = 80
  operator          = "GreaterThanOrEqual"
}

module "alert_memory_master" {
  source            = "../../../../modules/alerts/common_alerts"
  counts            = "002"
  Env               = var.Env
  rg_name           = var.rg_name
  resource_name     = "db-master"
  severity          = 3
  resource_id       = module.sql_server.sql_database_id
  action_group_id   = data.terraform_remote_state.base.outputs.action_group_id
  description       = "stoarge percentage is greater than 80%"
  metric_name       = "storage_percent"
  metric_namespace  = "Microsoft.Sql/servers/databases"
  aggregation       = "Average"
  threshold         = 80
  operator          = "GreaterThanOrEqual"
}
