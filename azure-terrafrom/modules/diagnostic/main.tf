resource "azurerm_monitor_diagnostic_setting" "diagnostic_setting" {
  name                          = "GS-mds-diagnostic-${var.Env}-eastus-${var.counts}"
  target_resource_id            = var.target_id
  storage_account_id            = var.storage_account_id
  log_analytics_workspace_id    = var.log_analytics_id

  enabled_log {
    category_group = "allLogs"
  }

  metric {
    category = "AllMetrics"
  }
}