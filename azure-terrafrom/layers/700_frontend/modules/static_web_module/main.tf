resource "azurerm_static_site" "Static_web_app" {
  name                = "GS-swa-webapp-${var.Env}-centralus-${var.counts}"
  resource_group_name = var.rg_name
  location            = "centralus"
  sku_tier            = var.sku 
  sku_size            = var.sku 

  tags = {
    Env = var.Env
    EnvAcct = local.EnvAcct
    AppSuite = "frontend"
  }
}