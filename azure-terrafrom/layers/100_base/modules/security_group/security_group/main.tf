resource "azurerm_network_security_group" "network_security_group" {
  name                = "GS-nsg-security-${var.Env}-eastus-${var.counts}"
  location            = var.rg_location
  resource_group_name = var.rg_name 
  
  tags = {
    Env = var.Env
    EnvAcct = local.EnvAcct
    Application = "act"
    AppSuite = "security_group"
  }

}