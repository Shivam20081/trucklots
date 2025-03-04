terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.68.0"
    }
    databricks = {
      source = "databricks/databricks"
      version = "1.24.1"
    }
  }
}