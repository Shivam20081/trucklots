resource "azurerm_public_ip" "public_ip" {
  name                = "gs-ip-publicip-${var.Env}"
  location            = var.rg_location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = {
      AppSuite    = "ip" 
      Env = var.Env
      Application = "act"
      EnvAcct = local.EnvAcct
        }
}