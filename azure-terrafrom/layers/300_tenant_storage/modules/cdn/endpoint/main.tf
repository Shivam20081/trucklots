resource "azurerm_cdn_endpoint" "cdn_endpoint" {
  name                = "gs${var.Env}cdnendpoint${var.counts}"
  profile_name        = var.cdn_name
  location            = "global"
  resource_group_name = var.rg_name
  is_http_allowed     = false
  origin_host_header  = var.host
  origin_path         = var.origin_path 

  origin {
    name      = "gs${var.Env}origin"
    host_name = var.host
  }
    
  dynamic "delivery_rule" {
    for_each = var.content_type == "json" ? [1,2] : []

    content {
      name  = delivery_rule.value == 1 ? "AppendCORS" : delivery_rule.value == 2 ? "OverwriteCORS" : "default"
      order = delivery_rule.value

      request_header_condition {
        selector      = "Origin"
        operator      = "Equal"
        match_values  = [var.frontend_url]
      }

      modify_response_header_action {
        action = delivery_rule.value == 1 ? "Append" : delivery_rule.value == 2 ? "Overwrite" : "default"
        name = "Access-Control-Allow-Origin"
        value = var.frontend_url
      }
    }
  }

  dynamic "global_delivery_rule" {
    for_each = var.content_type == "report" ? [1] : []

    content {
      cache_expiration_action {
        behavior = "BypassCache"
      }
    }
  }
  tags = {
    Env = var.Env
    EnvAcct = local.EnvAcct
    Application = "act"
    AppSuite = "endpoint"
  }
}

