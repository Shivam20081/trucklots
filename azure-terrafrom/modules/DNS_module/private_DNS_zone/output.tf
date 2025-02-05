output "id" {
  value = azurerm_private_dns_zone.dns.id
}

output "name" {
  value = azurerm_private_dns_zone.dns.name
}

output "databrick_dns_id" {
  value = azurerm_private_dns_zone.databrick_dns.id
}

output "databrick_dns_name" {
  value = azurerm_private_dns_zone.databrick_dns.name
}