data "terraform_remote_state" "base" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-demo-eus-001"
    storage_account_name = "stgstfstatedemoeus001"
    container_name       = "tfstate"
    key                  = "terraform_demo_eus_100_base.tfstate"
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