data "terraform_remote_state" "base" {
  backend = "azurerm"
  config =  {
    resource_group_name  = "rg-gs-tfstate-qa-eus-001"
    storage_account_name = "stgstfstateqaeus001"
    container_name       = "tfstate"
    key                  = "terraform_qa_eus_100_base.tfstate"
  }
}