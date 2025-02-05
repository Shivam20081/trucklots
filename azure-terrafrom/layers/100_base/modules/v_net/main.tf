resource "azurerm_virtual_network" "virtual_network" {
  name                = "GS-vnw-network-${var.Env}-eastus-${var.counts}"
  location            = var.rg_location
  resource_group_name = var.rg_name
  address_space       = [var.cidr_v_net]

  tags = {
    Env = var.Env
    Application = "act"
    EnvAcct = local.EnvAcct
    AppSutie = "v_net"
  }
}