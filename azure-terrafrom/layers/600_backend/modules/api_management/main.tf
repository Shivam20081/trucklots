resource "azurerm_api_management" "api_management" {
  name                = "GS-api-apimanagement-${var.Env}-eastus-${var.counts}"
  location            = var.rg_location
  resource_group_name = var.rg_name
  publisher_name      = var.publisher_name
  publisher_email     = var.publisher_email
  sku_name            = var.sku_name

  tags = {
    Env         = var.Env
    EnvAcct     = local.EnvAcct
    AppSuite    = "api_management"
    Application = "act"
  }
}

resource "azurerm_api_management_logger" "logger" {
  name                = "GS-api-apilogger-${var.Env}-eastus-${var.counts}"
  api_management_name = azurerm_api_management.api_management.name
  resource_group_name = var.rg_name
  resource_id         = var.application_insights_id

  application_insights {
    instrumentation_key = var.application_insights_key
  }
}