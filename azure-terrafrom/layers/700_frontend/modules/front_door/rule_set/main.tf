 resource "azurerm_cdn_frontdoor_rule_set" "rule_set" {
  name                     = "gsfrontdoor${var.Env}ruleset${var.counts}"
  cdn_frontdoor_profile_id = var.frontdoor_id
}