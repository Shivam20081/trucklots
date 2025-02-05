output "id" {
  value = azurerm_cdn_frontdoor_profile.frontdoor.id
}
output "resource_guid" {
  value = azurerm_cdn_frontdoor_profile.frontdoor.resource_guid
}

output "secret_id" {
  value = azurerm_cdn_frontdoor_secret.certificate.id
}