# output "service_connection_name" {
#   value = azurerm_data_factory_linked_service_azure_databricks.databrick_link.name
# }

output "data_factory_name" {
  value = azurerm_data_factory.datafactory.name
}

output "data_factory_id" {
  value = azurerm_data_factory.datafactory.id
}
