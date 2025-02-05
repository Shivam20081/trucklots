resource "azurerm_storage_account" "storage" {
  name                     = "greensight${var.Env}storage"
  resource_group_name      = var.rg_name
  location                 = "East US"
  account_tier             = "Standard"
  account_replication_type = "GRS"
  public_network_access_enabled = true
  enable_https_traffic_only = true
  is_hns_enabled           = true

  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    ignore_changes = [ 
      customer_managed_key 
    ]
  }

  blob_properties {
    cors_rule{
        allowed_headers = ["*"]
        allowed_methods = ["GET", "OPTIONS", "PUT", "HEAD"]
        allowed_origins = [var.frontend_url]
        exposed_headers = ["*"]
        max_age_in_seconds = 604800
    }

    delete_retention_policy {
      days = 7
    }

    container_delete_retention_policy {
      days = 7
    }
  }

  dynamic "static_website" {
    for_each = var.static_website ? [1] : []
    content {
      index_document   = "index.html"
      error_404_document = "error.html"
    }
  }

  tags = {
    Env = var.Env
    EnvAcct = local.EnvAcct
    AppSuite = "storage"
    Application = "act"
  }
}

resource "azurerm_key_vault_secret" "connection_string" {
  name         = "storage-connect-string-${var.Env}"
  value        = azurerm_storage_account.storage.primary_connection_string
  key_vault_id = var.key_vault_id

  depends_on = [ azurerm_storage_account.storage ]
}

