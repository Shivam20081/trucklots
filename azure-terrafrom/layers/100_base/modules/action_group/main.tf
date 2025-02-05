resource "azurerm_monitor_action_group" "action_group" {
  name                = "GS-acg-actiongroup-${var.Env}-global-${var.counts}"
  resource_group_name = var.rg_name
  short_name          = "${var.Env}-alerts"
 
  
  dynamic "email_receiver" {
    for_each = var.email
    content {
      name  = email_receiver.value.reciver_name
      email_address = email_receiver.value.reciver_email
    }
  }
  tags = {
    Env         = var.Env
    EnvAcct     = local.EnvAcct
    Application = "act"
    AppSuite    = "action_group"
  } 
}