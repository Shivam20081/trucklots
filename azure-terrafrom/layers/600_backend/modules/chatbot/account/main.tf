resource "azurerm_cognitive_account" "openai" {  
   name                     = "GS-chb-chatbot-${var.Env}-eastus-${var.counts}"  
   location                 = var.rg_location
   resource_group_name      = var.rg_name
   custom_subdomain_name    = "gs-chb-chatbot-${var.Env}-eastus-${var.counts}"
   kind                     = "OpenAI"  
   sku_name                 = "S0"  

   tags = {
    Env = var.Env
    Application="act"
    EnvAcct = local.EnvAcct
    AppSuite = "openai"
  }     
}
