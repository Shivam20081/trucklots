# 200_datalake

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.68.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-gs-tfstate-prod-eus-001"
    storage_account_name = "stgstfstateprodeus001"
    container_name       = "tfstate"
    key                  = "terraform_prod_eus_200_datalake.tfstate"
  }
  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}