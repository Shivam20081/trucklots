resource "azurerm_private_dns_zone" "dns" {
  name                = "privatelink.3.azurestaticapps.net"
  resource_group_name = var.rg_name
  tags = {
    Env = var.Env
    EnvAcct = local.EnvAcct
    Application = "act"
    AppSUite = "dns"
  }
}

resource "azurerm_private_dns_zone" "databrick_dns" {
  name                = "privatelink.azuredatabricks.net"
  resource_group_name = var.rg_name
  tags = {
    Env = var.Env
    EnvAcct = local.EnvAcct
    AppSUite = "dns"
    Application = "act"
  }
}

