resource "azurerm_container_app_environment" "app_enviornment" {
  name                                  = "GS-cae-appenv-${var.Env}-eastus-${var.counts}"
  location                              = var.rg_location
  resource_group_name                   = var.rg_name
  log_analytics_workspace_id            = var.log_analytics_id
  infrastructure_subnet_id              = var.subnet_id
  infrastructure_resource_group_name    = var.new_rg

  workload_profile {
    name = var.workload_profile_type
    workload_profile_type = var.workload_profile_type
    # maximum_count = var.max_count
    # minimum_count = var.min_count
  }
  
  tags = {
    Env = var.Env
    EnvAcct = local.EnvAcct
    AppSuite = "app_enviornment"
    Application = "act"
  } 
}   