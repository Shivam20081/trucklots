resource "azurerm_application_insights" "insight" {
  name                = "GS-ain-insight-${var.Env}-eastus-${var.counts}"
  location            = var.rg_location
  resource_group_name = var.rg_name
  application_type    = "Node.JS"

  tags = {
    Env = var.Env
    EnvAcct = local.EnvAcct
    AppSutie = "insight"
    Application = "act"
  }

}


