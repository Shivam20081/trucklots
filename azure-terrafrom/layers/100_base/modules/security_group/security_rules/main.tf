resource "azurerm_network_security_rule" "security_rule" {
  name                        = var.rule_name
  priority                    = var.priority
  direction                   = var.direction
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = var.port
  destination_port_range      = var.port
  source_address_prefix       = "*"
  destination_address_prefix  = "*"
  resource_group_name         = var.rg_name
  network_security_group_name = var.sg_name
}