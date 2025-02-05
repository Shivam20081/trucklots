resource "azurerm_service_plan" "service_plan" {
  name                = "GS-afa-function-${var.Env}-${var.rg_location}-${var.counts}"
  location            = var.rg_location
  resource_group_name = var.rg_name
  os_type             = "Linux"
  sku_name            = var.sku_name
}
