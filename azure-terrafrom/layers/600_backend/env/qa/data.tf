data "terraform_remote_state" "datalake" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-qa-eus-001"
    storage_account_name = "stgstfstateqaeus001"
    container_name       = "tfstate"
    key                  = "terraform_qa_eus_200_datalake.tfstate"
  }
}

data "terraform_remote_state" "tenant_storage" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-qa-eus-001"
    storage_account_name = "stgstfstateqaeus001"
    container_name       = "tfstate"
    key                  = "terraform_qa_eus_300_tenant_storage.tfstate"
  }
}

data "terraform_remote_state" "base" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-qa-eus-001"
    storage_account_name = "stgstfstateqaeus001"
    container_name       = "tfstate"
    key                  = "terraform_qa_eus_100_base.tfstate"
  }
}

data "terraform_remote_state" "database" {
  backend = "azurerm"
  config =  {
    resource_group_name  = "rg-gs-tfstate-qa-eus-001"
    storage_account_name = "stgstfstateqaeus001"
    container_name       = "tfstate"
    key                  = "terraform_qa_eus_500_database.tfstate"
  }
}

data "azurerm_client_config" "current" {}

data "azurerm_key_vault_certificate" "greensight_certificate" {
  name         = "greensight-feb-6"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "master_password" {
  name         = "sql-qa-master-appuser-password"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "master_username" {
  name         = "sql-qa-master-appuser-username"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "lowes_password" {
  name         = "sql-qa-lowes-appuser-password"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "lowes_username" {
  name         = "sql-qa-lowes-appuser-username"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "adm_password" {
  name         = "sql-qa-adm-appuser-password"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "adm_username" {
  name         = "sql-qa-adm-appuser-username"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "pepsi_password" {
  name         = "sql-qa-pepsi-appuser-password"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "pepsi_username" {
  name         = "sql-qa-pepsi-appuser-username"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "jwt_token" {
  name         = "jwt-token"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "live_account_sid" {
  name         = "live-account-sid"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "live_auth_token" {
  name         = "live-auth-token"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "live_twilio_number" {
  name         = "live-twilio-number"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "connection_string" {
  name         = "storage-connect-string-qa"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "acs_number" {
  name         = "acs-number"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "acs_endpoint" {
  name         = "acs-endpoint"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "acs_connection_string" {
  name         = "acs-connection-string"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "app_en_key" {
  name         = "react-app-en-key"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "chiper_salt" {
  name         = "chiper-salt"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "lane_route_url" {
  name         = "lane-route-url"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "logic_app_file_url" {
  name         = "logic-app-file-url"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "logic_app_url" {
  name         = "logic-app-url"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
} 

data "azurerm_key_vault_secret" "logic_cookies" {
  name         = "logic-cookies"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "google_api" {
  name         = "app-google-api-key"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azuread_user" "developers_user" {
  user_principal_name = "developers@greensight.ai"
}