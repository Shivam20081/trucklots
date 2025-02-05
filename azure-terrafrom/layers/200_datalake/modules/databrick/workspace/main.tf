resource "azurerm_databricks_workspace" "databrick" {
  name                        = "GS-dbw-databrick-${var.Env}-eastus-${var.counts}"
  resource_group_name         = var.rg_name1
  location                    = var.rg_location
  sku                         = "premium"
  managed_resource_group_name = var.rg_name2

  public_network_access_enabled         = true
  network_security_group_rules_required = "AllRules"

  custom_parameters {
    no_public_ip        = true
    public_subnet_name  = var.databrick_public_subnet_name #azurerm_subnet.public.name
    private_subnet_name = var.databrick_private_subnet_name #azurerm_subnet.private.name
    virtual_network_id  = var.virtual_network_id
    storage_account_name = var.storage_account_name
    storage_account_sku_name = var.storage_sku
    public_subnet_network_security_group_association_id  = var.public_subnet_network_security_group #azurerm_subnet_network_security_group_association.public.id
    private_subnet_network_security_group_association_id = var.private_subnet_network_security_group #azurerm_subnet_network_security_group_association.private.id
  }

  tags = {
    Env = var.Env
    EnvAcct = local.EnvAcct
    AppSuite = "databrick"
  }
}
