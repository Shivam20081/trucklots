
resource "azuread_application" "app_registor" {
  display_name     = "GS-aad-appregistor-${var.Env}-global-${var.counts}"
  owners           = [var.object_id]
  sign_in_audience = "AzureADMultipleOrgs"
}

resource "azuread_service_principal" "service_principal" {
  client_id                    = azuread_application.app_registor.client_id
  use_existing                 = true
}

resource "azuread_application_password" "app_password" {
  application_id = azuread_application.app_registor.id
  
}

resource "azurerm_key_vault_secret" "client_id" {
  name         = "gs-${var.Env}-client-id"
  value        = azuread_application.app_registor.client_id
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "client_secret" {
  name         = "gs-${var.Env}-client-secret"
  value        = azuread_application_password.app_password.value
  key_vault_id = var.key_vault_id
}
