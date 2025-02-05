# 700_frontend

terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.68.0"
    }
    azapi = {
      source  = "Azure/azapi"
      version = "~> 1.0"
    }
   
  }
  # WARNING: This has to be hardcoded because
  # variable resoultion is not allowed in the
  # terraform block.
  backend "azurerm" {
    resource_group_name  = "rg-gs-tfstate-qa-eus-001"
    storage_account_name = "stgstfstateqaeus001"
    container_name       = "tfstate"
    key                  = "terraform_qa_eus_700_frontend.tfstate"
  }
  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}
  
  subscription_id = var.subscription_id
}

provider "azapi" {}

