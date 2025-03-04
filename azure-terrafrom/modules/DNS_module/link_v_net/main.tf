resource "azurerm_private_dns_zone_virtual_network_link" "v_net_link" {
  name                  = "${var.Env}-v-net-link"
  resource_group_name   = var.rg_name
  private_dns_zone_name = var.DNS_name
  virtual_network_id    = var.vnet_id
  registration_enabled  = var.auto_registration
}