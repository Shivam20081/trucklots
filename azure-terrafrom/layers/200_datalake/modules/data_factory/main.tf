resource "azurerm_data_factory" "datafactory" {
  name                = "GS-adf-datafactory-${var.Env}-eastus-${var.counts}"
  location            = var.rg_location
  resource_group_name = var.rg_name

  tags = {
    Env         = var.Env
    EncAcct     = local.EnvAcct
    AppSuite    = "datafactory"
  }
}

resource "azurerm_data_factory_linked_service_azure_databricks" "databrick_link" {
  name                = "service link for azure databrick"
  data_factory_id     = azurerm_data_factory.datafactory.id
  description         = "ADB Linked Service via Access Token"
  existing_cluster_id = var.cluster_id

  access_token = var.access_token
  adb_domain   = "https://${var.workspace_url}"
}