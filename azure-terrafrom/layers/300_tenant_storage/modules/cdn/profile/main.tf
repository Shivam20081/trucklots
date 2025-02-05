resource "azurerm_cdn_profile" "cdn_profile" {
  name                = "GS-cdn-${var.Env}-global-${var.counts}"
  resource_group_name = var.rg_name
  location            = "global"
  sku                 = "Standard_Microsoft"

  tags = {
    Env = var.Env
    EnvAcct = local.EnvAcct
    Application = "act"
    AppSuite = "cdn"
  }
}