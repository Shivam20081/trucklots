data "terraform_remote_state" "base" {
  backend = "azurerm"
  config = {
    resource_group_name  = "rg-gs-tfstate-prod-eus-001"
    storage_account_name = "stgstfstateprodeus001"
    container_name       = "tfstate"
    key                  = "terraform_prod_eus_100_base.tfstate"
  }
}