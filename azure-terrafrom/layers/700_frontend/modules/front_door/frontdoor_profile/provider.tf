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
}

