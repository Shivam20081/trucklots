resource "azurerm_subnet" "subnet" {
  name                 = "GS-vnw-subnet-${var.Env}-eastus-${var.subnet_name}"
  resource_group_name  = var.rg_name
  virtual_network_name = var.v_net_name
  address_prefixes     = [var.subnet_cidr]
  # private_endpoint_network_policies = "Enabled"

  dynamic "delegation" {
    for_each = var.delegation == "databricks" ? [true] : []
    content {
      name = "databricks"

      service_delegation {
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action",
          "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
          "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action",
        ]
        name = "Microsoft.Databricks/workspaces"
      }
    }
  }

  dynamic "delegation" {
    for_each = var.delegation == "container_app" ? [true] : []
    content {
      name = "container-apps"

      service_delegation {
        name    = "Microsoft.App/environments"
        actions = [
          "Microsoft.Network/virtualNetworks/subnets/join/action"
        ]
      }
    }
  }
}