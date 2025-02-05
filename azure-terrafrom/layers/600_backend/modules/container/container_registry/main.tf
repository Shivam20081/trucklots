resource "azurerm_container_registry" "acr" {
  name                     = "gsacrregistory${var.Env}eastus${var.counts}"
  resource_group_name      = var.rg_name
  location                 = var.rg_location
  sku                      = var.sku_name
  admin_enabled            = true

  tags = {
    Env = var.Env
    EnvAcct = local.EnvAcct
    Application = "act"
    AppSuite = "registory"
  } 
  
}