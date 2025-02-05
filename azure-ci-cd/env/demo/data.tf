data "terraform_remote_state" "base" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-demo-eus-001"
    storage_account_name = "stgstfstatedemoeus001"
    container_name       = "tfstate"
    key                  = "terraform_demo_eus_100_base.tfstate"
  }
}

data "terraform_remote_state" "frontend" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-demo-eus-001"
    storage_account_name = "stgstfstatedemoeus001"
    container_name       = "tfstate"
    key                  = "terraform_demo_eus_700_frontend.tfstate"
  }
}

data "terraform_remote_state" "backend" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-demo-eus-001"
    storage_account_name = "stgstfstatedemoeus001"
    container_name       = "tfstate"
    key                  = "terraform_demo_eus_600_backend.tfstate"
  }
}

data "terraform_remote_state" "tenant_storage" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-demo-eus-001"
    storage_account_name = "stgstfstatedemoeus001"
    container_name       = "tfstate"
    key                  = "terraform_demo_eus_300_tenant_storage.tfstate"
  }
}

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

data "azurerm_key_vault_secret" "github_token" {
  name         = "github-token"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "sonar_token" {
  name         = "sonar-token"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "pipeline_token" {
  name         = "pipeline-token"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "app_base_url_asset_token" {
  name         = "app-base-url-asset-token"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "app_google_api_key" {
  name         = "app-google-api-key"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "app_base_url_asset" {
  name         = "app-base-url-asset"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "app_en_key" {
  name         = "app-en-key"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "username" {
  name         = "app-username" 
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "password" {
  name         = "app-password" 
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "app_base_url" {
  name         = "app-base-url" 
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "connection_string" {
  name         = "communication-connection-string" 
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}