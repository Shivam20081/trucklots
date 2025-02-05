output "public_ip" {
  value = azurerm_public_ip.public_ip.id
}

output "ip" {
  value = azurerm_public_ip.public_ip.ip_address
}