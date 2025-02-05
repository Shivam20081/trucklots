# 200_datalake

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.68.0"
    }
    databricks = {
      source = "databricks/databricks"
      version = "~> 1.24.1"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-gs-tfstate-qa-eus-001"
    storage_account_name = "stgstfstateqaeus001"
    container_name       = "tfstate"
    key                  = "terraform_qa_eus_200_datalake.tfstate"
  }
  # required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

provider "databricks" {
  host = "${module.databrick.workspace_url}"
  azure_workspace_resource_id = module.databrick.workspace_id
}