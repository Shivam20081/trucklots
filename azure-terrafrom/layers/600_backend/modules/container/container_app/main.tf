resource "azurerm_container_app" "container_app" {
  name                         = "gs-cap-container-${var.Env}-eastus-${var.counts}"
  container_app_environment_id = var.app_environment_id
  resource_group_name          = var.rg_name
  revision_mode                = "Single"
  
  registry {
    server = var.acr_server
    username = var.acr_username
    password_secret_name = "acr-password"
  }

  secret { 
    name  = "acr-password" 
    value = var.acr_password
  }

  secret { 
    name  = "gsacrregistory${var.Env}eastus001azurecrio-gsacrregistory${var.Env}eastus001" 
    value = var.acr_password
  }

  template {
    min_replicas = var.min_replicas
    max_replicas = var.max_replicas

    custom_scale_rule {
      name = "cputhreshold"
      custom_rule_type = "cpu"
      metadata = {
        type = "utilization"
        value = 70
      }
    }
    container {
      name   = "gs-cap-container-${var.Env}-eastus-${var.counts}"
      image  = var.image
      cpu    = var.container_cpu
      memory = var.container_memory

      dynamic "env" {
        for_each = var.environment_variable
        content {
          name  = env.value.name
          value = env.value.value
        }
      }
    }   

  }

  ingress {
    target_port      = var.container_port
    external_enabled = true 

    traffic_weight {
      latest_revision = true
      percentage      = 100 
    }
  }

  tags = {
    Env = var.Env
    EnvAcct = local.EnvAcct
    Application = "act"
    AppSuite = "container_app"
  } 
}