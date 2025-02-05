resource "azurerm_cdn_frontdoor_profile" "frontdoor" {
  name                = "GS-fd-frontdoor-${var.Env}-eastus-${var.counts}"
  resource_group_name = var.rg_name
  sku_name            = var.sku_name
  response_timeout_seconds = var.timeout

  tags = {
    Env = var.Env
    EnvAcct = local.EnvAcct
    AppSuite = "frontdoor"
  }
}

resource "azapi_update_resource" "frontdoor_system_identity" {
  type        = "Microsoft.Cdn/profiles@2023-02-01-preview"
  resource_id = azurerm_cdn_frontdoor_profile.frontdoor.id
  body = jsonencode({"identity": {
            "type": "UserAssigned",
            "userAssignedIdentities": {
                "${var.identity_id}": {}
            }
        }}
    )
}


resource "azurerm_cdn_frontdoor_secret" "certificate" {
  name                     = "greensight"
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.frontdoor.id

  secret {
    customer_certificate {
      key_vault_certificate_id = var.certificate_id
    }
  }
}