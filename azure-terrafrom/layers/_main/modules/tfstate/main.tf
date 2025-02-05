# tfstate module

locals {
  # Region abbreviation
  reg = var.region == "East US" ? "eus" : "cus"
}

resource "azurerm_resource_group" "tfstate" {
  name     = "rg-gs-tfstate-${var.Env}-${local.reg}-001"
  location = var.region
}

resource "azurerm_storage_account" "tfstate" {
  name                     = "stgstfstate${var.Env}${local.reg}001"
  resource_group_name      = azurerm_resource_group.tfstate.name
  location                 = azurerm_resource_group.tfstate.location
  account_tier             = "Standard"
  account_replication_type = "RAGZRS"
  tags                     = var.tags
}

resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}