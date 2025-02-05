data "terraform_remote_state" "base" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-demo-eus-001"
    storage_account_name = "stgstfstatedemoeus001"
    container_name       = "tfstate"
    key                  = "terraform_demo_eus_100_base.tfstate"
  }
}

data "terraform_remote_state" "storage" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-demo-eus-001"
    storage_account_name = "stgstfstatedemoeus001"
    container_name       = "tfstate"
    key                  = "terraform_demo_eus_300_tenant_storage.tfstate"
  }
}


data "azurerm_key_vault_certificate" "greensight_certificate" {
  name         = "greensight-feb-6"
  key_vault_id = data.terraform_remote_state.base.outputs.key_vault_id
}
