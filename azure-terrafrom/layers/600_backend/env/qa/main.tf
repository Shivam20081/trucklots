# 600_backend

module "application_insight" {
  source        = "../../../../modules/application_insight"
  Env           = var.Env
  counts        = "001"
  rg_name       = var.rg_name
  rg_location   = var.rg_location

}

module "app_service_plan_001" {
  source            = "../../modules/azure_function_app/app_service_plan"
  Env               = var.Env
  counts            = "001"
  rg_name           = var.rg_name
  rg_location       = var.rg_location
  sku_name          = "Y1"
}

module "funciton_app_001" {
  source                                  = "../../modules/azure_function_app/function_app"
  Env                                     = var.Env
  counts                                  = "001"
  rg_name                                 = var.rg_name
  rg_location                             = var.rg_location
  frontend_url                            = ["https://app-qa.greensight.ai", "http://localhost:3000"]
  storage_account_name                    = data.terraform_remote_state.tenant_storage.outputs.storage_account_name
  application_insights_key                = module.application_insight.instrumentation_key
  storage_access_key                      = data.terraform_remote_state.tenant_storage.outputs.storage_primary_access_key
  application_insights_connection_string  = module.application_insight.connection_string
  identity_id                             = data.terraform_remote_state.base.outputs.identity_id
  service_plan_id                         = module.app_service_plan_001.id
  application_stack                       = {node_version = 18}
  apply_ip_restriction                    = false
  appsuite                                = "backend"
  app_env_variables = {
      WEBSITES_ENABLE_APP_SERVICE_STORAGE     = true
      WEBSITE_ENABLE_SYNC_UPDATE_SITE         = false
      FUNCTIONS_REQUEST_BODY_SIZE_LIMIT       = 2000000000
      REQUEST_TIMEOUT                         = 30000
      CONNECTION_TIMEOUT                      = 30000

      BLOB_URL                                = "https://${data.terraform_remote_state.tenant_storage.outputs.cdn_endpoint}"
      BASE_URL                                = "https://app-qa.greensight.ai"
      AZURE_STORAGE_ACCOUNT_NAME              = data.terraform_remote_state.tenant_storage.outputs.storage_account_name
      AZURE_STORAGE_ACCOUNT_KEY               = data.terraform_remote_state.tenant_storage.outputs.storage_primary_access_key
      AZURE_STORAGE_CONNECTION_STRING         = data.azurerm_key_vault_secret.connection_string.value
      
      JWT_TOKEN                               = data.azurerm_key_vault_secret.jwt_token.value
      JWT_EXPIRE_TIME                         = "168h"
      ENCRYPTION_KEY                          = data.azurerm_key_vault_secret.app_en_key.value
      
      ENV                                     = "QA"
      POLLER_WAIT_TIME                        = 10
      SENDER_ADDRESS                          = "donotreply@greensight.ai"
      
      LIVE_ACCOUNT_SID                        = data.azurerm_key_vault_secret.live_account_sid.value
      LIVE_AUTH_TOKEN                         = data.azurerm_key_vault_secret.live_auth_token.value
      LIVE_TWILIO_NUMBER                      = data.azurerm_key_vault_secret.live_twilio_number.value

      DB_HOST                                 = "${data.terraform_remote_state.database.outputs.sql_server_name}.database.windows.net"
      DB_DRIVER                               = "mssql"

      DB_LOWES_NAME                           = data.terraform_remote_state.database.outputs.sql_lowes_database_name
      DB_LOWES_USER                           = data.azurerm_key_vault_secret.lowes_username.value
      DB_LOWES_PASSWORD                       = data.azurerm_key_vault_secret.lowes_password.value

      DB_MASTER_NAME                          = data.terraform_remote_state.database.outputs.sql_master_database_name
      DB_MASTER_USER                          = data.azurerm_key_vault_secret.master_username.value
      DB_MASTER_PASSWORD                      = data.azurerm_key_vault_secret.master_password.value

      DB_PEPSI_NAME                           = data.terraform_remote_state.database.outputs.sql_pepsi_database_name
      DB_PEPSI_USER                           = data.azurerm_key_vault_secret.pepsi_username.value
      DB_PEPSI_PASSWORD                       = data.azurerm_key_vault_secret.pepsi_password.value

      ACS_NUMBER                              = data.azurerm_key_vault_secret.acs_number.value
      ACS_ENDPOINT                            = data.azurerm_key_vault_secret.acs_endpoint.value
      ACS_CONNECTION_CREDENTIAL               = data.azurerm_key_vault_secret.acs_connection_string.value
    
      CIPHER_SALT                             = data.azurerm_key_vault_secret.chiper_salt.value
      CIPHER_PASSWORD                         = true
      PASSWORD_EXPIRE_DAYS_LIMIT              = 60
      PASSWORD_EXPIRE_WARNING_DAYS            = 45
      APP_GOOGLE_API_KEY                      = data.azurerm_key_vault_secret.google_api.value
      PROFILE_PATH                            = "assets/images/profile/"

      DB_ADM_NAME                             = data.terraform_remote_state.database.outputs.sql_adm_database_name 
      DB_ADM_PASSWORD                         = data.azurerm_key_vault_secret.adm_password.value  
      DB_ADM_USER                             = data.azurerm_key_vault_secret.adm_username.value
      
      LANE_ROUTES_URL                         = data.azurerm_key_vault_secret.lane_route_url.value
     
      LOGIC_APP_FILE_URL                      = data.azurerm_key_vault_secret.logic_app_file_url.value
      LOGIC_APP_URL                           = data.azurerm_key_vault_secret.logic_app_url.value 
      LOGIC_COOKIE                            = data.azurerm_key_vault_secret.logic_cookies.value 
    }
    depends_on = [ module.app_service_plan_001 ]
}

module "app_service_plan_002" {
  source            = "../../modules/azure_function_app/app_service_plan"
  Env               = var.Env
  counts            = "002"
  rg_name           = var.rg_name
  rg_location       = var.rg_location
  sku_name          = "Y1"
}

module "funciton_app_002" {
  source                                  = "../../modules/azure_function_app/function_app"
  Env                                     = var.Env
  counts                                  = "002"
  rg_name                                 = var.rg_name
  rg_location                             = var.rg_location
  frontend_url                            = ["https://app-qa.greensight.ai"]
  storage_account_name                    = data.terraform_remote_state.tenant_storage.outputs.storage_account_name
  application_insights_key                = module.application_insight.instrumentation_key
  storage_access_key                      = data.terraform_remote_state.tenant_storage.outputs.storage_primary_access_key
  application_insights_connection_string  = module.application_insight.connection_string
  identity_id                             = data.terraform_remote_state.base.outputs.identity_id
  service_plan_id                         = module.app_service_plan_002.id
  application_stack                       = {python_version = "3.10"}
  apply_ip_restriction                    = false
  appsuite                                = "devops"
  app_env_variables = {
      WEBSITES_ENABLE_APP_SERVICE_STORAGE     = true
      WEBSITE_ENABLE_SYNC_UPDATE_SITE         = false
      FUNCTIONS_REQUEST_BODY_SIZE_LIMIT       = 2000000000
      REQUEST_TIMEOUT                         = 30000
      CONNECTION_TIMEOUT                      = 30000

      SUBSCRIPTION_ID                         = var.subscription_id
      ENV                                     = var.Env
      CLIENT_ID                               = data.terraform_remote_state.base.outputs.client_id
      CLIENT_SECREAT                          = data.terraform_remote_state.base.outputs.client_secret
      TENANT_ID                               = data.azurerm_client_config.current.tenant_id
      ADF_NAME                                = data.terraform_remote_state.datalake.outputs.data_factory_name
      RG_NAME                                 = "GREENSIGHT-${upper(var.Env)}-MISC"

    }
    depends_on = [ module.app_service_plan_002 ]
}


module "app_service_plan_003" {
  source            = "../../modules/azure_function_app/app_service_plan"
  Env               = var.Env
  counts            = "003"
  rg_name           = var.rg_name
  rg_location       = var.rg_location
  sku_name          = "Y1"
}

module "funciton_app_003" {
  source                                  = "../../modules/azure_function_app/function_app"
  Env                                     = var.Env
  counts                                  = "003"
  rg_name                                 = var.rg_name
  rg_location                             = var.rg_location
  frontend_url                            = ["https://app-qa.greensight.ai"]
  storage_account_name                    = data.terraform_remote_state.tenant_storage.outputs.storage_account_name
  application_insights_key                = module.application_insight.instrumentation_key
  storage_access_key                      = data.terraform_remote_state.tenant_storage.outputs.storage_primary_access_key
  application_insights_connection_string  = module.application_insight.connection_string
  identity_id                             = data.terraform_remote_state.base.outputs.identity_id
  service_plan_id                         = module.app_service_plan_003.id
  application_stack                       = {custom_runtime = true}
  apply_ip_restriction                    = false
  appsuite                                = "rust"
  app_env_variables = {
      WEBSITES_ENABLE_APP_SERVICE_STORAGE     = true
      WEBSITE_ENABLE_SYNC_UPDATE_SITE         = false
      FUNCTIONS_REQUEST_BODY_SIZE_LIMIT       = 2000000000
      REQUEST_TIMEOUT                         = 30000
      CONNECTION_TIMEOUT                      = 30000
    }
    depends_on = [ module.app_service_plan_003 ]
}

module "app_service_plan_004" {
  source            = "../../modules/azure_function_app/app_service_plan"
  Env               = var.Env
  counts            = "004"
  rg_name           = var.rg_name
  rg_location       = var.rg_location
  sku_name          = "Y1"
}

module "funciton_app_004" {
  source                                  = "../../modules/azure_function_app/function_app"
  Env                                     = var.Env
  counts                                  = "004"
  rg_name                                 = var.rg_name
  rg_location                             = var.rg_location
  frontend_url                            = ["https://app-qa.greensight.ai", "http://localhost:3000"]
  storage_account_name                    = data.terraform_remote_state.tenant_storage.outputs.storage_account_name
  application_insights_key                = module.application_insight.instrumentation_key
  storage_access_key                      = data.terraform_remote_state.tenant_storage.outputs.storage_primary_access_key
  application_insights_connection_string  = module.application_insight.connection_string
  identity_id                             = data.terraform_remote_state.base.outputs.identity_id
  service_plan_id                         = module.app_service_plan_004.id
  application_stack                       = {node_version = 18}
  apply_ip_restriction                    = false
  appsuite                                = "backend"
  app_env_variables = {
      WEBSITES_ENABLE_APP_SERVICE_STORAGE     = true
      WEBSITE_ENABLE_SYNC_UPDATE_SITE         = false
      FUNCTIONS_REQUEST_BODY_SIZE_LIMIT       = 2000000000
      REQUEST_TIMEOUT                         = 30000
      CONNECTION_TIMEOUT                      = 30000
    }
    depends_on = [ module.app_service_plan_004 ]
}


module "container_registry_001" {
  source            = "../../modules/container/container_registry"
  Env               = var.Env
  counts            = "001"
  rg_name           = var.rg_name
  rg_location       = var.rg_location
  sku_name          = "Basic"
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
  container_memory    = "0.5Gi"
  container_cpu       = "0.25"
  container_port      = 8000
  min_replicas        = 1
  max_replicas        = 2
  app_environment_id  = module.container_app_environment_001.id
  acr_password        = module.container_registry_001.admin_password
  acr_server          = module.container_registry_001.login_server
  acr_username        = module.container_registry_001.admin_username
  image               = "${module.container_registry_001.login_server}/gs-backend-qa-001"
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
      value   = "QA"
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
}

module "api_management" {
  source                    = "../../modules/api_management"
  Env                       = var.Env
  counts                    = "001"
  rg_name                   = var.rg_name
  rg_location               = var.rg_location
  application_insights_key  = module.application_insight.instrumentation_key
  application_insights_id   = module.application_insight.id
  publisher_email           = "services@greensight.ai"
  publisher_name            = "Greensight-${var.Env}"
  sku_name                  = "Consumption_0"
}
################################################## MONITRING ###########################################

module "monitoring" {
  source              = "../../../../modules/diagnostic"
  Env                 = var.Env
  counts              = "001"
  target_id           = module.funciton_app_001.id
  storage_account_id  = data.terraform_remote_state.tenant_storage.outputs.storage_account_id
  log_analytics_id    = data.terraform_remote_state.base.outputs.log_analytics_id
}

module "monitoring_devops" {
  source              = "../../../../modules/diagnostic"
  Env                 = var.Env
  counts              = "002"
  target_id           = module.funciton_app_002.id
  storage_account_id  = data.terraform_remote_state.tenant_storage.outputs.storage_account_id
  log_analytics_id    = data.terraform_remote_state.base.outputs.log_analytics_id
}

module "monitoring_rust" {
  source              = "../../../../modules/diagnostic"
  Env                 = var.Env
  counts              = "003"
  target_id           = module.funciton_app_003.id
  storage_account_id  = data.terraform_remote_state.tenant_storage.outputs.storage_account_id
  log_analytics_id    = data.terraform_remote_state.base.outputs.log_analytics_id
}

module "monitoring_admin" {
  source              = "../../../../modules/diagnostic"
  Env                 = var.Env
  counts              = "005"
  target_id           = module.funciton_app_004.id
  storage_account_id  = data.terraform_remote_state.tenant_storage.outputs.storage_account_id
  log_analytics_id    = data.terraform_remote_state.base.outputs.log_analytics_id
}

module "monitoring_apim" {
  source              = "../../../../modules/diagnostic"
  Env                 = var.Env
  counts              = "004"
  target_id           = module.api_management.id
  storage_account_id  = data.terraform_remote_state.tenant_storage.outputs.storage_account_id
  log_analytics_id    = data.terraform_remote_state.base.outputs.log_analytics_id
}

################################################## ROLES ###########################################

module "insight_access" {
  source = "../../../../modules/access_control/assign_role"
  resource_id = module.application_insight.id
  permission = "reader"
  object_id = data.azuread_user.developers_user.object_id
}

module "function_app_001_access" {
  source = "../../../../modules/access_control/assign_role"
  resource_id = module.funciton_app_001.id
  permission = "log_reader_qa"
  object_id = data.azuread_user.developers_user.object_id
}

module "function_app_003_access" {
  source = "../../../../modules/access_control/assign_role"
  resource_id = module.funciton_app_003.id
  permission = "log_reader_qa"
  object_id = data.azuread_user.developers_user.object_id
}

module "function_app_004_access" {
  source = "../../../../modules/access_control/assign_role"
  resource_id = module.funciton_app_004.id
  permission = "log_reader_qa"
  object_id = data.azuread_user.developers_user.object_id
}