output "client_secret" {
  value = azuread_application_password.app_password.value
  sensitive = true
}

output "client_id" {
  value = azuread_application.app_registor.client_id
}

output "object_id" {
  value = azuread_application.app_registor.object_id
}

output "sp_id" {
  value = azuread_service_principal.service_principal.id
}