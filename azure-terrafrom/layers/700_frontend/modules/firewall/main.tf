resource "azurerm_cdn_frontdoor_security_policy" "security_policy" {
  name                     = "GS-fsp-security-${var.Env}-eastus-${var.counts}"
  cdn_frontdoor_profile_id = var.profile_id

  security_policies {
    firewall {
      cdn_frontdoor_firewall_policy_id = azurerm_cdn_frontdoor_firewall_policy.firewall.id
      association {
        domain {
          cdn_frontdoor_domain_id = var.custom_domain_id
        }
        patterns_to_match = ["/*"]
      }
    }
  }
}

resource "azurerm_cdn_frontdoor_firewall_policy" "firewall" {
  name                              = "GSffpfirewall${var.Env}eastus${var.counts}"
  resource_group_name               = var.rg_name
  sku_name                          = var.sku_name
  enabled                           = true
  mode                              = "Prevention"
  custom_block_response_status_code = 403

  managed_rule {
      type    = "Microsoft_DefaultRuleSet"
      version = "2.1"
      action  = "Log"
  }
}