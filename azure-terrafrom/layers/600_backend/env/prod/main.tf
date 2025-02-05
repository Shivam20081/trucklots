# 600_backend

module "application_insight" {
  source          = "../../../../modules/application_insight"
  Env             = var.Env
  counts          = "001"
  rg_name         = var.rg_name
  rg_location     = var.rg_location

}

module "azure_function_app" {
  source                                  = "../../modules/azure_function_app/function_app_application"
  counts                                  = 001
  Env                                     = var.Env
  frontend_url                            = ["https://act.greensight.ai", "https://evdashboard.greensight.ai"]
  storage_account_name                    = data.terraform_remote_state.tenant_storage.outputs.storage_account_name
  storage_primary_access_key              = data.terraform_remote_state.tenant_storage.outputs.storage_primary_access_key
  rg_name                                 = var.rg_name
  application_insights_key                = module.application_insight.instrumentation_key
  application_insights_connection_string  = module.application_insight.connection_string
  allowed_ip                              = "${data.terraform_remote_state.base.outputs.ip}/32"
  app_env_variables = {
      WEBSITES_ENABLE_APP_SERVICE_STORAGE       = true
      WEBSITE_ENABLE_SYNC_UPDATE_SITE           = true
      FUNCTIONS_REQUEST_BODY_SIZE_LIMIT         = 2000000000
      REQUEST_TIMEOUT                           = 30000
      CONNECTION_TIMEOUT                        = 30000

      BLOB_URL                                  = "https://${data.terraform_remote_state.tenant_storage.outputs.cdn_endpoint}"
      BASE_URL                                  = "https://act.greensight.ai"
      AZURE_STORAGE_ACCOUNT_NAME                = data.terraform_remote_state.tenant_storage.outputs.storage_account_name
      AZURE_STORAGE_ACCOUNT_KEY                 = data.terraform_remote_state.tenant_storage.outputs.storage_primary_access_key
      AZURE_STORAGE_CONNECTION_STRING           = data.azurerm_key_vault_secret.connection_string.value
      
      JWT_TOKEN                                 = data.azurerm_key_vault_secret.jwt_token.value
      JWT_EXPIRE_TIME                           = "12h"
      
      ENCRYPTION_KEY                            = data.azurerm_key_vault_secret.app_en_key.value
      DB_HOST                                   = "${data.terraform_remote_state.database.outputs.sql_server_name}.database.windows.net"
      DB_DRIVER                                 = "mssql"
      
      LIVE_ACCOUNT_SID                          = data.azurerm_key_vault_secret.live_account_sid.value
      LIVE_AUTH_TOKEN                           = data.azurerm_key_vault_secret.live_auth_token.value
      LIVE_TWILIO_NUMBER                        = data.azurerm_key_vault_secret.live_twilio_number.value
      
      ENV                                       = "PRODUCTION"
      POLLER_WAIT_TIME                          = 10
      SENDER_ADDRESS                            = "donotreply@greensight.ai"

      DB_LOWES_NAME                             = data.terraform_remote_state.database.outputs.sql_lowes_database_name
      DB_LOWES_USER                             = data.azurerm_key_vault_secret.lowes_username.value
      DB_LOWES_PASSWORD                         = data.azurerm_key_vault_secret.lowes_password.value

      DB_MASTER_NAME                            = data.terraform_remote_state.database.outputs.sql_master_database_name
      DB_MASTER_USER                            = data.azurerm_key_vault_secret.master_username.value
      DB_MASTER_PASSWORD                        = data.azurerm_key_vault_secret.master_password.value

      DB_PEPSI_NAME                             = data.terraform_remote_state.database.outputs.sql_pepsi_database_name
      DB_PEPSI_USER                             = data.azurerm_key_vault_secret.pepsi_username.value
      DB_PEPSI_PASSWORD                         = data.azurerm_key_vault_secret.pepsi_password.value

      ACS_NUMBER                                = data.azurerm_key_vault_secret.acs_number.value
      ACS_ENDPOINT                              = data.azurerm_key_vault_secret.acs_endpoint.value
      ACS_CONNECTION_CREDENTIAL                 = data.azurerm_key_vault_secret.acs_connection_string.value
      
      CIPHER_SALT                               = data.azurerm_key_vault_secret.chiper_salt.value
      CIPHER_PASSWORD                           = true
      PASSWORD_EXPIRE_DAYS_LIMIT                = 60
      PASSWORD_EXPIRE_WARNING_DAYS              = 45
      APP_GOOGLE_API_KEY                        = data.azurerm_key_vault_secret.google_api.value

      MY_SQL_HOST_PEPSI                         = data.azurerm_key_vault_secret.mysql_host_pepsi.value
      MY_SQL_TOKEN                              = data.azurerm_key_vault_secret.mysql_token.value
      DB_PEPSI_NAME_EV                          = data.azurerm_key_vault_secret.db_pepsi_name_ev.value
      DB_PEPSI_USER_EV                          = data.azurerm_key_vault_secret.db_pepsi_user_ev.value
      DB_PEPSI_PASSWORD_EV                      = data.azurerm_key_vault_secret.db_pepsi_password_ev.value
    }
}

module "private_endpoint1" {
  source          = "../../../../modules/endpoint_module"
  rg_name         = var.rg_name
  rg_location     = var.rg_location
  subnet_id       = data.terraform_remote_state.base.outputs.private_link_subnet_id
  link_name       = module.azure_function_app.function_app_name[0]
  pe_resource_id  = module.azure_function_app.function_app_id[0]
  Env             = var.Env
  subresource_name = ["sites"]
  private_dns_zone_group            = false

}

module "private_endpoint2" {
  source              = "../../../../modules/endpoint_module"
  rg_name             = var.rg_name
  rg_location         = var.rg_location
  subnet_id           = data.terraform_remote_state.base.outputs.private_link_subnet_id
  link_name           = module.azure_function_app.function_app_name[1]
  pe_resource_id      = module.azure_function_app.function_app_id[1]
  Env                 = var.Env
  subresource_name    = ["sites"]
  private_dns_zone_group            = false

}

module "application_gateway_firewall" {
  source                        = "../../modules/firewall_poilcy"
  Env                           = var.Env
  counts                        = "001"
  rg_location                   = var.rg_location
  rg_name                       = var.rg_name 
}

module "application_gateway_001" {
  source              = "../../modules/applicaiton_gatway"
  counts              = "001"
  sku                 = "WAF_v2"
  Env                 = var.Env
  subnet_id           = data.terraform_remote_state.base.outputs.application_gateway_subnet_id
  public_ip           = data.terraform_remote_state.base.outputs.public_ip_id
  rg_location         = var.rg_location
  firewall_policy_id  = module.application_gateway_firewall.id
  rg_name             = var.rg_name
  certificate_id      = data.azurerm_key_vault_certificate.greensight_certificate.secret_id
  identity_id         = data.terraform_remote_state.base.outputs.identity_id 
  targaet_list        = ["${module.azure_function_app.default_dns[0]}","${module.azure_function_app.default_dns[1]}"] 
}

module "chatbot_functionapp" {
  source                                  = "../../modules/azure_function_app/function_app_chatbot"
  counts                                  = "004"
  Env                                     = var.Env
  frontend_url                            = ["https://act.greensight.ai"]
  storage_account_name                    = data.terraform_remote_state.tenant_storage.outputs.storage_account_name
  storage_primary_access_key              = data.terraform_remote_state.tenant_storage.outputs.storage_primary_access_key
  rg_name                                 = var.rg_name
  application_insights_key                = module.application_insight.instrumentation_key
  application_insights_connection_string  = module.application_insight.connection_string
  identity_id                             = data.terraform_remote_state.base.outputs.identity_id

  app_env_variables = {
    AZURE_ENDPOINT                      = module.open_ai.endpoint
    AZURE_OPENAI_API_KEY                = module.open_ai.access_key
    OPENAI_API_TYPE                     = "azure"
    OPENAI_API_VERSION                  = "2014-02-01"
    OPENAI_CHAT_MODEL                   = "gpt-4o"

    DB_MASTER_NAME                      = data.terraform_remote_state.database.outputs.sql_master_database_name
    DB_MASTER_PASSWORD                  = data.azurerm_key_vault_secret.chatbot_master_password.value
    DB_MASTER_SCHEMA                    = "greensight_master"
    DB_MASTER_USERNAME                  = data.azurerm_key_vault_secret.chatbot_master_username.value

    DB_PEPSI_NAME                       = data.terraform_remote_state.database.outputs.sql_pepsi_database_name
    DB_PEPSI_PASSWORD                   = data.azurerm_key_vault_secret.chatbot_pepsi_password.value
    DB_PEPSI_SCHEMA                     = "greensight_pepsi"
    DB_PEPSI_USERNAME                   = data.azurerm_key_vault_secret.chatbot_pepsi_username.value

    Host                                = "${data.terraform_remote_state.database.outputs.sql_server_name}.database.windows.net"
    JWT_TOKEN                           = data.azurerm_key_vault_secret.jwt_token.value
  }
}

module "open_ai" {
  source        = "../../modules/chatbot/account"
  Env           = var.Env
  counts        = "001"
  rg_location   = var.rg_location
  rg_name       = var.rg_name
  subnet_id     = data.terraform_remote_state.base.outputs.private_link_subnet_id
}

module "open_ai_model" {
  source            = "../../modules/chatbot/deployment"
  Env               = var.Env
  counts            = "001"
  open_id           = module.open_ai.id
  model_name        = "gpt-4o" 
  model_version     = "2024-05-13" 
  token_capacity    = 30
  deployment_type   = "GlobalStandard"

  depends_on = [ module.open_ai ]
}

module "container_registry_001" {
  source            = "../../modules/container/container_registry"
  Env               = var.Env
  counts            = "001"
  rg_name           = var.rg_name
  rg_location       = var.rg_location
  sku_name          = "Standard"
}

module "container_app_environment_001" {
  source                = "../../modules/container/container_environment"
  Env                   = var.Env
  counts                = "001"
  rg_name               = var.rg_name
  rg_location           = var.rg_location
  log_analytics_id      = data.terraform_remote_state.base.outputs.log_analytics_id
  subnet_id             = data.terraform_remote_state.base.outputs.container_app_subnet_id
  new_rg                = "${var.rg_name}-CA"
  workload_profile_type = "Consumption"
}

module "container_app_001" {
  source              = "../../modules/container/container_app"
  Env                 = var.Env
  counts              = "001"
  rg_name             = var.rg_name
  container_memory    = "2Gi"
  container_cpu       = "1"
  container_port      = 8000
  min_replicas        = 1
  max_replicas        = 4
  app_environment_id  = module.container_app_environment_001.id
  acr_password        = module.container_registry_001.admin_password
  acr_server          = module.container_registry_001.login_server
  acr_username        = module.container_registry_001.admin_username
  image               = "nginx"
  environment_variable = [
    {
      name    = "DB_HOST"
      value   = "${data.terraform_remote_state.database.outputs.sql_server_name}.database.windows.net"
    },
    { 
      name    = "DB_MASTER_NAME"
      value   = data.terraform_remote_state.database.outputs.sql_master_database_name
    },
    {
      name    = "DB_MASTER_USER"
      value   = data.azurerm_key_vault_secret.master_username.value
    },
    {
      name    = "DB_MASTER_PASSWORD"                    
      value   = data.azurerm_key_vault_secret.master_password.value
    }, 
    {
      name    = "DB_LOWES_NAME"
      value   = data.terraform_remote_state.database.outputs.sql_lowes_database_name
    }, 
    {
      name    = "DB_LOWES_USER"
      value   = data.azurerm_key_vault_secret.lowes_username.value
    }, 
    {
      name    = "DB_LOWES_PASSWORD"
      value   = data.azurerm_key_vault_secret.lowes_password.value
    }, 
    {
      name    = "DB_PEPSI_NAME"
      value   = data.terraform_remote_state.database.outputs.sql_pepsi_database_name
    }, 
    {
      name    = "DB_PEPSI_USER"
      value   = data.azurerm_key_vault_secret.pepsi_username.value
    }, 
    {
      name    = "DB_PEPSI_PASSWORD"
      value   = data.azurerm_key_vault_secret.pepsi_password.value
    }, 
    {
      name    = "JWT_TOKEN"
      value   = data.azurerm_key_vault_secret.jwt_token.value
    }, 
    {
      name    = "ENV"
      value   = "PRODUCTION"
    }, 
    {
      name    = "ENCRYPTION_KEY"
      value   = data.azurerm_key_vault_secret.app_en_key.value
    }, 
    {
      name    = "DB_ADM_NAME"
      value   = data.terraform_remote_state.database.outputs.sql_adm_database_name 
    }, 
    {
      name    = "DB_ADM_PASSWORD"
      value   = data.azurerm_key_vault_secret.adm_password.value 
    }, 
    {
      name    = "DB_ADM_USER"
      value   = data.azurerm_key_vault_secret.adm_username.value
    }
  ]
  depends_on = [ module.container_app_environment_001, module.container_registry_001 ]
}


############################################### MONITORING #####################################################

module "monitoring_open_ai" {
  source              = "../../../../modules/diagnostic"
  Env                 = var.Env
  counts              = "001"
  target_id           = module.open_ai.id
  storage_account_id  = data.terraform_remote_state.tenant_storage.outputs.storage_account_id
  log_analytics_id    = data.terraform_remote_state.base.outputs.log_analytics_id
}

module "monitoring_app_gateway_001" {
  source              = "../../../../modules/diagnostic"
  Env                 = var.Env
  counts              = "001"
  target_id           = module.application_gateway_001.id
  storage_account_id  = data.terraform_remote_state.tenant_storage.outputs.storage_account_id
  log_analytics_id    = data.terraform_remote_state.base.outputs.log_analytics_id
}

module "monitoring_chatbot_functionapp" {
  source              = "../../../../modules/diagnostic"
  Env                 = var.Env
  counts              = "001"
  target_id           = module.chatbot_functionapp.id
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
  description       = "Request count is greater then 1000 on ${upper(var.Env)} Application Gateway Backend"
  metric_name       = "TotalRequests"
  metric_namespace  = "Microsoft.Network/applicationGateways"
  aggregation       = "Total"
  threshold         = 1000
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