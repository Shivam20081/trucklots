# 600_backend

module "application_insight" {
  source              = "../../../../modules/application_insight"
  Env                 = var.Env
  counts              = "001"
  rg_name             = var.rg_name
  rg_location         = var.rg_location

}

module "azure_function_app" {
  source                      = "../../modules/azure_function_app/function_app_application"
  counts                      = 001
  Env                         = var.Env
  frontend_url                = ["https://demo.greensight.ai"]
  storage_account_name        = data.terraform_remote_state.tenant_storage.outputs.storage_account_name
  storage_primary_access_key  = data.terraform_remote_state.tenant_storage.outputs.storage_primary_access_key
  rg_name                     = var.rg_name
  application_insights_key    = module.application_insight.instrumentation_key
  application_insights_connection_string = module.application_insight.connection_string
  allowed_ip                  = "${data.terraform_remote_state.base.outputs.ip}/32"

  app_env_variables = {
      WEBSITES_ENABLE_APP_SERVICE_STORAGE     = true
      WEBSITE_ENABLE_SYNC_UPDATE_SITE         = true
      FUNCTIONS_REQUEST_BODY_SIZE_LIMIT       = 2000000000
      REQUEST_TIMEOUT                         = 30000
      CONNECTION_TIMEOUT                      = 30000
      
      JWT_EXPIRE_TIME                         = "12h"
      JWT_TOKEN                               = data.azurerm_key_vault_secret.jwt_token.value
      BLOB_URL                                = "https://${data.terraform_remote_state.tenant_storage.outputs.cdn_endpoint}/"

      DB_HOST                                 = "${data.terraform_remote_state.database.outputs.sql_server_name}.database.windows.net"
      DB_DRIVER                               = "mssql"
      ENV                                     = "PRODUCTION"
      ENCRYPTION_KEY                          = data.azurerm_key_vault_secret.app_en_key.value
      LIVE_ACCOUNT_SID                        = data.azurerm_key_vault_secret.live_account_sid.value
      LIVE_AUTH_TOKEN                         = data.azurerm_key_vault_secret.live_auth_token.value
      LIVE_TWILIO_NUMBER                      = data.azurerm_key_vault_secret.live_twilio_number.value
      
      AZURE_STORAGE_ACCOUNT_NAME              = data.terraform_remote_state.tenant_storage.outputs.storage_account_name
      AZURE_STORAGE_CONNECTION_STRING         = data.azurerm_key_vault_secret.connection_string.value
      AZURE_STORAGE_ACCOUNT_KEY               = data.azurerm_key_vault_secret.stroage_account_key.value

      DB_LOWES_NAME                           = data.terraform_remote_state.database.outputs.sql_lowes_database_name
      DB_LOWES_USER                           = data.azurerm_key_vault_secret.lowes_username.value
      DB_LOWES_PASSWORD                       = data.azurerm_key_vault_secret.lowes_password.value

      DB_MASTER_NAME                          = data.terraform_remote_state.database.outputs.sql_master_database_name
      DB_MASTER_USER                          = data.azurerm_key_vault_secret.master_username.value
      DB_MASTER_PASSWORD                      = data.azurerm_key_vault_secret.master_password.value

      ACS_NUMBER                              = data.azurerm_key_vault_secret.acs_number.value
      ACS_ENDPOINT                            = data.azurerm_key_vault_secret.acs_endpoint.value
      ACS_CONNECTION_CREDENTIAL               = data.azurerm_key_vault_secret.acs_connection_string.value
    
      CIPHER_SALT                             = data.azurerm_key_vault_secret.chiper_salt.value
      CIPHER_PASSWORD                         = true

      PASSWORD_EXPIRE_DAYS_LIMIT              = 60
      PASSWORD_EXPIRE_WARNING_DAYS            = 45

      POLLER_WAIT_TIME                        = 10
      SENDER_ADDRESS                          = "donotreply@greensight.ai"
      BASE_URL                                = "https://demo.greensight.ai"

    }
}

module "azure_research_function_app" {
  source                      = "../../modules/azure_function_app/function_app_application"
  counts                      = 001
  Env                         = "research"
  frontend_url                = ["https://research.greensight.ai"]
  storage_account_name        = data.terraform_remote_state.tenant_storage.outputs.storage_account_name
  storage_primary_access_key  = data.terraform_remote_state.tenant_storage.outputs.storage_primary_access_key
  rg_name                     = "GREENSIGHT-RESEARCH-BACKEND"
  application_insights_key    = module.application_insight.instrumentation_key
  application_insights_connection_string = module.application_insight.connection_string
  allowed_ip                  = null

  app_env_variables = {
      WEBSITES_ENABLE_APP_SERVICE_STORAGE     = true
      WEBSITE_ENABLE_SYNC_UPDATE_SITE         = false
      FUNCTIONS_REQUEST_BODY_SIZE_LIMIT       = 2000000000
      REQUEST_TIMEOUT                         = 30000
      CONNECTION_TIMEOUT                      = 30000
      
      JWT_EXPIRE_TIME                         = "12h"
      JWT_TOKEN                               = data.azurerm_key_vault_secret.jwt_token.value
      BLOB_URL                                = "https://${data.terraform_remote_state.tenant_storage.outputs.cdn_endpoint}/"

      DB_HOST                                 = "${data.terraform_remote_state.database.outputs.sql_server_name}.database.windows.net"
      DB_DRIVER                               = "mssql"
      ENV                                     = "PRODUCTION"
      ENCRYPTION_KEY                          = data.azurerm_key_vault_secret.app_en_key.value
      LIVE_ACCOUNT_SID                        = data.azurerm_key_vault_secret.live_account_sid.value
      LIVE_AUTH_TOKEN                         = data.azurerm_key_vault_secret.live_auth_token.value
      LIVE_TWILIO_NUMBER                      = data.azurerm_key_vault_secret.live_twilio_number.value
      

      AZURE_STORAGE_ACCOUNT_NAME              = data.terraform_remote_state.tenant_storage.outputs.storage_account_name
      AZURE_STORAGE_CONNECTION_STRING         = data.azurerm_key_vault_secret.connection_string.value
      AZURE_STORAGE_ACCOUNT_KEY               = data.azurerm_key_vault_secret.stroage_account_key.value

      DB_LOWES_NAME                           = data.terraform_remote_state.database.outputs.sql_lowes_database_name
      DB_LOWES_USER                           = data.azurerm_key_vault_secret.lowes_username.value
      DB_LOWES_PASSWORD                       = data.azurerm_key_vault_secret.lowes_password.value

      DB_MASTER_NAME                          = data.terraform_remote_state.database.outputs.sql_master_database_name
      DB_MASTER_USER                          = data.azurerm_key_vault_secret.master_username.value
      DB_MASTER_PASSWORD                      = data.azurerm_key_vault_secret.master_password.value

      ACS_NUMBER                              = data.azurerm_key_vault_secret.acs_number.value
      ACS_ENDPOINT                            = data.azurerm_key_vault_secret.acs_endpoint.value
      ACS_CONNECTION_CREDENTIAL               = data.azurerm_key_vault_secret.acs_connection_string.value
    
      CIPHER_SALT                             = data.azurerm_key_vault_secret.chiper_salt.value
      CIPHER_PASSWORD                         = true
    }
}

module "private_endpoint1" {
  source                            = "../../../../modules/endpoint_module"
  rg_name                           = var.rg_name
  rg_location                       = var.rg_location
  subnet_id                         = data.terraform_remote_state.base.outputs.private_link_subnet_id
  link_name                         = module.azure_function_app.function_app_name[0]
  pe_resource_id                    = module.azure_function_app.function_app_id[0]
  Env                               = var.Env
  DNS_id                            = data.terraform_remote_state.base.outputs.DNS_zone_id
  subresource_name                  = ["sites"]
  private_dns_zone_group            = false
}

module "private_endpoint2" {
  source                            = "../../../../modules/endpoint_module"
  rg_name                           = var.rg_name
  rg_location                       = var.rg_location
  subnet_id                         = data.terraform_remote_state.base.outputs.private_link_subnet_id
  link_name                         = module.azure_function_app.function_app_name[1]
  pe_resource_id                    = module.azure_function_app.function_app_id[1]
  Env                               = var.Env
  subresource_name                  = ["sites"]
  private_dns_zone_group            = false

}

module "application_gateway_001" {
  source              = "../../modules/applicaiton_gatway"
  counts              = "001"
  sku                 = "Standard_v2"
  Env                 = var.Env
  subnet_id           = data.terraform_remote_state.base.outputs.application_gateway_subnet_id
  public_ip           = data.terraform_remote_state.base.outputs.public_ip_id
  rg_location         = var.rg_location
  firewall_policy_id  = null
  rg_name             = var.rg_name
  certificate_id      = data.azurerm_key_vault_certificate.greensight_certificate.secret_id
  identity_id         = data.terraform_remote_state.base.outputs.identity_id 
  targaet_list        = ["${module.azure_function_app.default_dns[0]}","${module.azure_function_app.default_dns[1]}"] 
}

############################################### MONITORING #####################################################

module "monitoring_app_gateway_001" {
  source              = "../../../../modules/diagnostic"
  Env                 = var.Env
  counts              = "001"
  target_id           = module.application_gateway_001.id
  storage_account_id  = data.terraform_remote_state.tenant_storage.outputs.storage_account_id
  log_analytics_id    = data.terraform_remote_state.base.outputs.log_analytics_id
}

#################################################### ALERTS ##############################################

module "alert_001" {
  source            = "../../../../modules/alerts/common_alerts"
  Env               = var.Env
  counts            = "001"
  rg_name           = var.rg_name
  resource_name     = "app_gateway"
  severity          = 2
  resource_id       = module.application_gateway_001.id
  action_group_id   = data.terraform_remote_state.base.outputs.action_group_id
  description       = "Request count is greater then 500 on ${upper(var.Env)} Application Gateway Backend"
  metric_name       = "TotalRequests"
  metric_namespace  = "Microsoft.Network/applicationGateways"
  aggregation       = "Total"
  threshold         = 500
  operator          = "GreaterThan"
}


module "backend_custom_alert_001" {
  source            = "../../../../modules/alerts/custom_alerts"
  Env               = var.Env
  counts            = "001"
  rg_location       = var.rg_location
  rg_name           = var.rg_name
  auto_resolve      = true
  log_analytics_id  = data.terraform_remote_state.base.outputs.log_analytics_id
  action_group_id   = data.terraform_remote_state.base.outputs.action_group_id
  description       = "Backend Error in ${upper(var.Env)} environment."
  severity          = 2
  query             = <<-QUERY
                      AGWAccessLogs 
                      | where HttpStatus > 499 and RequestUri contains "/api"
                      QUERY
}