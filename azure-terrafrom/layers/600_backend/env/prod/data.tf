data "terraform_remote_state" "tenant_storage" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-prod-eus-001"
    storage_account_name = "stgstfstateprodeus001"
    container_name       = "tfstate"
    key                  = "terraform_prod_eus_300_tenant_storage.tfstate"
  }
}

data "terraform_remote_state" "database" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-prod-eus-001"
    storage_account_name = "stgstfstateprodeus001"
    container_name       = "tfstate"
    key                  = "terraform_prod_eus_500_database.tfstate"
  }
}

data "terraform_remote_state" "base" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-prod-eus-001"
    storage_account_name = "stgstfstateprodeus001"
    container_name       = "tfstate"
    key                  = "terraform_prod_eus_100_base.tfstate"
  }
}


data "azurerm_key_vault_certificate" "greensight_certificate" {
  name         = "geensight-feb-6-2023"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "master_password" {
  name         = "sql-prod-master-appuser-password"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "master_username" {
  name         = "sql-prod-master-appuser-username"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "lowes_password" {
  name         = "sql-prod-lowes-appuser-password"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "lowes_username" {
  name         = "sql-prod-lowes-appuser-username"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "pepsi_password" {
  name         = "sql-prod-pepsi-appuser-password"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "pepsi_username" {
  name         = "sql-prod-pepsi-appuser-username"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "adm_password" {
  name         = "sql-prod-adm-appuser-password"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "adm_username" {
  name         = "sql-prod-adm-appuser-username"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "chatbot_pepsi_username" {
  name         = "sql-prod-pepsi-chatbot-username"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "chatbot_pepsi_password" {
  name         = "sql-prod-pepsi-chatbot-password"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}


data "azurerm_key_vault_secret" "chatbot_master_username" {
  name         = "sql-prod-master-chatbot-username"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "chatbot_master_password" {
  name         = "sql-prod-master-chatbot-password"
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
  name         = "storage-connect-string-prod"
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

data "azurerm_key_vault_secret" "app_base_url" {
  name         = "app-base-url" 
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "app_en_key" {
  name         = "app-en-key"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "chiper_salt" {
  name         = "cipher-salt"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "google_api" {
  name         = "app-google-api-key"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "mysql_host_pepsi" {
  name         = "mysql-host-pepsi"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "mysql_token" {
  name         = "mysql-token"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "db_pepsi_name_ev" {
  name         = "db-pepsi-name-ev"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "db_pepsi_user_ev" {
  name         = "db-pepsi-user-ev"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "db_pepsi_password_ev" {
  name         = "db-pepsi-password-ev"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}
