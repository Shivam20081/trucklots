data "terraform_remote_state" "tenant_storage" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-demo-eus-001"
    storage_account_name = "stgstfstatedemoeus001"
    container_name       = "tfstate"
    key                  = "terraform_demo_eus_300_tenant_storage.tfstate"
  }
}

data "terraform_remote_state" "base" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-demo-eus-001"
    storage_account_name = "stgstfstatedemoeus001"
    container_name       = "tfstate"
    key                  = "terraform_demo_eus_100_base.tfstate"
  }
}

data "terraform_remote_state" "database" {
  backend = "azurerm"
  config =  {
    resource_group_name  = "rg-gs-tfstate-demo-eus-001"
    storage_account_name = "stgstfstatedemoeus001"
    container_name       = "tfstate"
    key                  = "terraform_demo_eus_500_database.tfstate"
  }
}

data "azurerm_key_vault_certificate" "greensight_certificate" {
  name         = "greensight-feb-6"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "master_password" {
  name         = "sql-demo-master-appuser-password"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "master_username" {
  name         = "sql-demo-master-appuser-username"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "lowes_password" {
  name         = "sql-demo-lowes-appuser-password"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "lowes_username" {
  name         = "sql-demo-lowes-appuser-username"
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
  name         = "storage-connect-string-demo"
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
  name         = "app-en-key"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "stroage_account_key" {
  name         = "storage-account-key"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}

data "azurerm_key_vault_secret" "chiper_salt" {
  name         = "cipher-salt"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}