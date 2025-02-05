module "project" {
  source              = "../../module/project"
  Env                 = var.Env
  github_token        = data.azurerm_key_vault_secret.github_token.value
  sonar_token         = data.azurerm_key_vault_secret.sonar_token.value
  tenant_id           = data.azurerm_client_config.current.tenant_id
  subscription_id     = var.subscription_id
  subscription_name   = data.azurerm_subscription.current.display_name
}

module "frontend" {
  source                  = "../../module/frontend_pipeline"
  Env                     = upper(var.Env)
  project_id              = module.project.project_id
  trigger                 = true
  github_branch           = "demo"
  github_repo             = "Scope23-GreenSight/greensight_frontend"
  ymlpath                 = "azure/demo-frontendpipeline.yml"
  service_connection_id   = module.project.github_service_connection

# ENVIRONMENT VARIABLES FOR PIPELINE
  environment_variable = [
    {
      name = "STATIC_WEB_APP_TOKEN"
      secret_value = data.terraform_remote_state.frontend.outputs.webapp_token
    },
    {
      name = "REACT_APP_BASE_URL"
      secret_value = data.azurerm_key_vault_secret.app_base_url.value
    },
    {
      name = "REACT_APP_BASE_URL_ASSET_TOKEN"
      secret_value =  data.azurerm_key_vault_secret.app_base_url_asset_token.value
    },
    {
      name = "REACT_APP_BASE_URL_ASSET"
      secret_value =  data.azurerm_key_vault_secret.app_base_url_asset.value
    },
    {
      name = "REACT_APP_GOOGLE_API_KEY"
      secret_value =  data.azurerm_key_vault_secret.app_google_api_key.value
    },
    {
      name = "REACT_APP_EN_KEY"
      secret_value =  data.azurerm_key_vault_secret.app_en_key.value
    },
    {
      name = "REACT_APP_CDN_URL"
      secret_value = "https://${data.terraform_remote_state.tenant_storage.outputs.cdn_endpoint}/"
    }
  ]
}

module "backend" {
  source                  = "../../module/backend_pipeline"
  Env                     = upper(var.Env)
  project_id              = module.project.project_id
  trigger                 = true
  github_branch           = "demo"
  github_repo             = "Scope23-GreenSight/greensight_backend"
  ymlpath                 = "azure/demo-backend-pipeline.yml"
  service_connection_id   = module.project.github_service_connection

# ENVIRONMENT VARIABLES FOR PIPELINE
  environment_variable = [
    {
      name = "FUNCTION_APP_NAME1"
      secret_value = data.terraform_remote_state.backend.outputs.function_app_name1
    },
    {
      name = "FUNCTION_APP_NAME2"
      secret_value =  data.terraform_remote_state.backend.outputs.function_app_name2
    },
  ]
}

module "research_backend" {
  source                  = "../../module/backend_pipeline"
  Env                     = upper("research")
  project_id              = module.project.project_id
  trigger                 = true
  github_branch           = "research"
  github_repo             = "Scope23-GreenSight/greensight_backend"
  ymlpath                 = "azure/research-backend-pipeline.yml"
  service_connection_id   = module.project.github_service_connection

# ENVIRONMENT VARIABLES FOR PIPELINE
  environment_variable = [
    {
      name = "FUNCTION_APP_NAME"
      secret_value = data.terraform_remote_state.backend.outputs.research_function[0]
    },
  ]
}

module "test_suite" {
  source = "../../module/test_suit_pipeline"
  Env                     = upper(var.Env)
  project_id              = module.project.project_id
  trigger                 = true
  github_branch           = "Develop"
  github_repo             = "Scope23-GreenSight/greensight_test_suite"
  ymlpath                 = "azure/test-suite.yml"
  service_connection_id   = module.project.github_service_connection

  days_to_build           = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
  starting_hours          = 11
  starting_min            = 30

  environment_variable    = [
    {
      name            = "INVALID_USERNAME"
      secret_value    = "auto.demo@greensight.com"
    },
    {
      name            = "INVALID_PASSWORD"
      secret_value    = "ao4c(qc0s#xa"
    },
    {
      name            = "USERNAME"
      secret_value    = data.azurerm_key_vault_secret.username.value
    },
    {
      name            = "PASSWORD"
      secret_value    = data.azurerm_key_vault_secret.password.value
    },
    {
      name            = "BASE_URL"
      secret_value    = "https://demo.greensight.ai"
    },
    {
      name            = "STORAGE_ACCOUNT_NAME"
      secret_value    = data.terraform_remote_state.tenant_storage.outputs.storage_account_name
    },
    {
      name            = "CONNECTION_STRING"
      secret_value    = data.azurerm_key_vault_secret.connection_string.value
    },
    {
      name            = "SENDER_EMAIL"
      secret_value    = "DoNotReply@greensight.ai"
    },
    {
      name            = "EMAIL_TO"
      secret_value    = "bhojanehanumant@bugraptors.com, singhparamveer@seasiainfotech.com, sainishivani@seasiainfotech.com, singhharpreet2@seasiainfotech.com, gosainashish@seasiainfotech.com, bhatiaravinder@bugraptors.com, vipandhiman@bugraptors.com, kumardeepak@seasiainfotech.com, kumarniraj@seasiainfotech.com, vikrant@seasiainfotech.com, mishrashubham@bugraptors.com"
    },
    {
      name            = "SUBJECT"
      secret_value    = "Demo Greensight Automation Test Reports"
    },
    {
      name            = "BODY"
      secret_value    = "Hello Team Please view today's Automation Test Report for Demo Environement :  https://demo-report.greensight.ai/ "
    }
  ]
}