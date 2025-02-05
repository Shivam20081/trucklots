resource "azurerm_mssql_virtual_network_rule" "v_net_link" {
  name      = var.rule_name
  server_id = var.server_id
  subnet_id = var.subnet_id
}