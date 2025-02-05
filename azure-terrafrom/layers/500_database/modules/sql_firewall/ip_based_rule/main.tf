resource "azurerm_mssql_firewall_rule" "access" {
  name             = var.firewall_rule_name
  server_id        = var.server_id
  start_ip_address = var.starting_from_ip
  end_ip_address   = var.ending_ip
}