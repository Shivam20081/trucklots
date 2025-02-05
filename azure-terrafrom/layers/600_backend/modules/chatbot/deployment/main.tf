resource "azurerm_cognitive_deployment" "deployment" {
  name                 = "GS-chb-model-${var.Env}-eastus-${var.counts}"
  cognitive_account_id = var.open_id

  model {
    format  = "OpenAI"
    name    = var.model_name 
    version = var.model_version 
  }

  scale {
    capacity = var.token_capacity  
    type = var.deployment_type 
  }
}