terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.7.0"
    }
    azuredevops = {
      source = "microsoft/azuredevops"
      version = "0.5.0"
    } 
  }
  backend "azurerm" {
    resource_group_name  = "rg-gs-tfstate-qa-eus-001"
    storage_account_name = "stgstfstateqaeus001"
    container_name       = "tfstate"
    key                  = "terraform_qa_azure_ci_cd.tfstate"
  }
  required_version = ">= 1.5.0"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id 
}

provider "azuredevops" {
  org_service_url= var.org_service_url
  personal_access_token= data.azurerm_key_vault_secret.pipeline_token.value
}