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