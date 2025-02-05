output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "storage_account_id" {
  value = azurerm_storage_account.storage.id
}

output "principal_id" {
  value = azurerm_storage_account.storage.identity.0.principal_id
}

output "storage_primary_access_key" {
  value = azurerm_storage_account.storage.primary_access_key
}

output "endpoint" {
  value = azurerm_storage_account.storage.primary_blob_endpoint 
}

output "static_website_url" {
  
  value = var.static_website ? azurerm_storage_account.storage.primary_web_endpoint : null
}
