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
}

# provider "azurerm" {
#   features {}
# }

# provider "azuredevops" {
#   org_service_url= var.org_service_url
#   personal_access_token= var.pipeline_token 
# }