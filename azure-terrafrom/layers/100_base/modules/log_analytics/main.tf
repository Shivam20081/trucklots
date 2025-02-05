resource "azurerm_log_analytics_workspace" "log_analytics" {
  name                = "GS-law-analytics-${var.Env}-eastus-${var.counts}"
  location            = var.rg_location
  resource_group_name = var.rg_name
  sku                 = "PerGB2018" 
  retention_in_days   = 90
  tags                = {
                        Env = var.Env
                        EnvAcct = local.EnvAcct
                        AppSuite = "log_analytics"
                        Application = "act"
  }
}

