resource "azurerm_subnet_network_security_group_association" "security_group_association" {
  subnet_id                 = var.subnet_id 
  network_security_group_id = var.security_group_id
}