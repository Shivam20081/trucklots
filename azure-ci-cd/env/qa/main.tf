# Azure CI-CD QA

module "project" {
  source            = "../../module/project"
  Env               = var.Env
  github_token      = data.azurerm_key_vault_secret.github_token.value
  sonar_token       = data.azurerm_key_vault_secret.sonar_token.value
  tenant_id         = data.azurerm_client_config.current.tenant_id
  subscription_id   = var.subscription_id
  acr_name          = data.terraform_remote_state.backend.outputs.acr_name
  subscription_name = data.azurerm_subscription.current.display_name
}

module "frontend_001" {
  source        = "../../module/trigger_pipeline"
  Env           = upper(var.Env)
  tech          = "React"
  app_suite     = "Frontend"
  trigger       = true
  project_id    = module.project.project_id
  github_branch = var.Env
  github_repo   = "scope23-GreenSight/greensight_frontend"
  ymlpath       = "azure/qa-frontendpipeline.yml"
  service_connection_id = module.project.github_service_connection

# ENVIRONMENT VARIABLES FOR PIEPLINE AND FRONTEND
  environment_variable = [
    {
      name            = "STATIC_WEB_APP_TOKEN"
      secret_value    = data.terraform_remote_state.frontend.outputs.webapp_token
    },
    {
      name            = "REACT_APP_BASE_URL"
      secret_value    = data.azurerm_key_vault_secret.app_base_url.value
    },
    {
      name            = "REACT_APP_GOOGLE_API_KEY"
      secret_value    = data.azurerm_key_vault_secret.app_google_api_key.value
    },
    {
      name            = "REACT_APP_BASE_URL_ASSET"
      secret_value    = data.azurerm_key_vault_secret.app_base_url_asset.value
    },
    {
      name            = "REACT_APP_BASE_URL_ASSET_TOKEN"
      secret_value    = data.azurerm_key_vault_secret.app_base_url_asset_token.value
    },
    {
      name            = "REACT_APP_EN_KEY"
      secret_value    = data.azurerm_key_vault_secret.app_en_key.value
    },
    {
      name            = "REACT_APP_CDN_URL"
      secret_value    = "https://${data.terraform_remote_state.tenant_storage.outputs.cdn_endpoint}/"
    },
    {
      name            = "REACT_APP_INGETION_URL"
      secret_value    = "https://${data.terraform_remote_state.backend.outputs.funciton_app_002_name}.azurewebsites.net/api/"
    },
    {
      name            = "REACT_APP_PROGRESS_TIME"
      secret_value    = 5000
    },
    {
      name            = "REACT_APP_IS_OPTIMUS"
      secret_value    = true
    },
    {
      name            = "REACT_APP_BASE_URL_CHARTBOAT"
      secret_value    = "https://chatbot-dev.greensight.ai/api/sqlquery"
    },
    {
      name            = "REACT_APP_BASE_URL_ADMIN"
      secret_value    = "https://api-qa.greensight.ai/api/"
    },
    {
      name            = "skipSonar"
      secret_value    = false
    },
    {
      name            = "REACT_APP_FUNCTIONAL_URL"
      secret_value    = "https://${data.terraform_remote_state.backend.outputs.funciton_app_003_name}.azurewebsites.net/api/fuel-stops"
    },
    {
      name            = "SONAR_PROJECT_KEY"
      secret_value    = data.azurerm_key_vault_secret.sonar_project_key_frontend.value
    },
    {
      name            = "SONAR_PROJECT_NAME"
      secret_value    = data.azurerm_key_vault_secret.sonar_project_name_frontend.value
    },
    {
      name            = "REACT_APP_DUMMY_EMAIL"
      secret_value    = data.azurerm_key_vault_secret.dummy_email.value
    },
    {
      name            = "REACT_APP_DUMMY_PASSWORD"
      secret_value    = data.azurerm_key_vault_secret.dummy_password.value
    }
  ]
}

module "backend_track" {
  source            = "../../module/trigger_pipeline"
  Env               = upper(var.Env)
  tech              = "Node"
  app_suite         = "Backend-Track"
  project_id        = module.project.project_id
  github_branch     = "qa"
  trigger           = true
  github_repo       = "scope23-GreenSight/greensight_backend"
  ymlpath           = "azure/qa-backend-pipeline.yml"
  service_connection_id = module.project.github_service_connection

# ENVIRONMENT VARIABLES FOR PIPELINE
  environment_variable = [
    {
      name                  = "FUNCTION_APP_NAME1"
      secret_value          = data.terraform_remote_state.backend.outputs.funciton_app_001_name
    },
    {
      name                  = "ENCRYPTION_KEY"
      secret_value          = data.azurerm_key_vault_secret.app_en_key.value
    },
    {
      name                  = "SONAR_PROJECT_KEY"
      secret_value          = data.azurerm_key_vault_secret.sonar_project_key_backend.value
    },
    {
      name                  = "SONAR_PROJECT_NAME"
      secret_value          = data.azurerm_key_vault_secret.sonar_project_name_backend.value
    },
    {
      name                  = "skipSonar"
      secret_value          = false
    }
  ]
}

module "devops_001" {
  source                = "../../module/trigger_pipeline"
  Env                   = upper(var.Env)
  project_id            = module.project.project_id
  tech                  = "Python"
  app_suite             = "DevOps"
  github_branch         = "qa"
  trigger               = true
  github_repo           = "scope23-GreenSight/greensight_devops"
  ymlpath               = "azure/qa-pipeline.yml"
  service_connection_id = module.project.github_service_connection

# ENVIRONMENT VARIABLES FOR PIPELINE
  environment_variable = [
    {
      name                  = "FUNCTION_APP_NAME"
      secret_value          = data.terraform_remote_state.backend.outputs.funciton_app_002_name
    }
  ]
}

module "backend_node" {
  source                  = "../../module/trigger_pipeline"
  Env                     = upper(var.Env)
  trigger                 = true
  tech                    = "Docker"
  app_suite               = "Backend-Node"
  project_id              = module.project.project_id
  github_branch           = "qa"
  github_repo             = "scope23-GreenSight/greensight_backend_ca"
  ymlpath                 = "azure/qa_pipeline.yml"
  service_connection_id   = module.project.github_service_connection

  environment_variable = [
    {
      name            = "ACR_NAME"
      secret_value    = data.terraform_remote_state.backend.outputs.acr_name
    },
    {
      name            = "ACR_PASSWORD"
      secret_value    = data.terraform_remote_state.backend.outputs.acr_password
    },
    {
      name            = "CONTAINER_APP_NAME"
      secret_value    = data.terraform_remote_state.backend.outputs.container_app_name
    },
    {
      name            = "RG_NAME"
      secret_value    = "greensight-qa-backend"
    },
    {
      name            = "CONTAINER_APP_NAME"
      secret_value    = data.terraform_remote_state.backend.outputs.container_app_name
    }
  ]
}

module "backend_app" {
  source            = "../../module/trigger_pipeline"
  Env               = upper(var.Env)
  tech              = "Node"
  app_suite         = "Backend-App"
  project_id        = module.project.project_id
  github_branch     = "qa"
  trigger           = true
  github_repo       = "scope23-GreenSight/greensight_backend_act_admin"
  ymlpath           = "azure/qa-backend-pipeline.yml"
  service_connection_id = module.project.github_service_connection

# ENVIRONMENT VARIABLES FOR PIPELINE
  environment_variable = [
    {
      name                  = "FUNCTION_APP_NAME1"
      secret_value          = data.terraform_remote_state.backend.outputs.funciton_app_004_name
    },
    {
      name                  = "ENCRYPTION_KEY"
      secret_value          = data.azurerm_key_vault_secret.app_en_key.value
    },
    {
      name                  = "skipSonar"
      secret_value          = false
    }
  ]
}