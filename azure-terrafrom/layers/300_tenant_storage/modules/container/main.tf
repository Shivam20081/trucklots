resource "azurerm_storage_container" "container" {
  name                  = var.container_name
  storage_account_name  = var.storage_name
  container_access_type =  var.container_type #"private"
}


