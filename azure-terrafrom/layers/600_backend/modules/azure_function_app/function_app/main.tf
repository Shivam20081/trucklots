
resource "azurerm_linux_function_app" "function_app" {
  name                = "GS-afa-function-${var.Env}-${var.rg_location}-${var.counts}"
  location            = var.rg_location
  resource_group_name = var.rg_name

  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.storage_access_key
  service_plan_id            = var.service_plan_id

  site_config {
    elastic_instance_minimum               = 1
    application_insights_connection_string = var.application_insights_connection_string
    application_insights_key               = var.application_insights_key

    cors {
      allowed_origins = var.frontend_url
      support_credentials = true
    }
   
    application_stack {
      node_version   = lookup(var.application_stack, "node_version", null)
      python_version = lookup(var.application_stack, "python_version", null)
      use_custom_runtime = lookup(var.application_stack, "custom_runtime", null)
    }

    dynamic "ip_restriction" {
      for_each = var.apply_ip_restriction ? [1] : []
      content {
        action      = "Allow"
        ip_address  = var.allowed_ip
        service_tag = "LogicApps"
      }
    }
  }
   
  app_settings = var.app_env_variables

  identity {
    type = "UserAssigned"
    identity_ids = [var.identity_id]
  }

  tags = {
    Env     = var.Env
    EnvAcct = local.EnvAcct
    AppSuite = var.appsuite
    Application = "act"
  }
}

resource "azurerm_linux_function_app_slot" "slot" {
  
  name                 = "stand-by"
  function_app_id      = azurerm_linux_function_app.function_app.id
  storage_account_name = var.storage_account_name

  site_config {
    elastic_instance_minimum               = 1
    application_insights_connection_string = var.application_insights_connection_string
    application_insights_key               = var.application_insights_key

    cors {
      allowed_origins = var.frontend_url
      support_credentials = true
    }
   
    application_stack {
      node_version   = lookup(var.application_stack, "node_version", null)
      python_version = lookup(var.application_stack, "python_version", null)
      use_custom_runtime = lookup(var.application_stack, "custom_runtime", null)
    }

    dynamic "ip_restriction" {
      for_each = var.apply_ip_restriction ? [1] : []
      content {
        action      = "Allow"
        ip_address  = var.allowed_ip
        service_tag = "LogicApps"
      }
    }
  }
   
  app_settings = var.app_env_variables

  identity {
    type = "UserAssigned"
    identity_ids = [var.identity_id]
  }

  tags = {
    Env     = var.Env
    EnvAcct = local.EnvAcct
    AppSuite = "stand_by_${var.appsuite}"
    Application = "act"
  }

}