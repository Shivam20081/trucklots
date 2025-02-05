resource "azurerm_cdn_frontdoor_endpoint" "endpoint" {
  name                     = "gs-frontdoor-${var.Env}-${var.counts}"
  cdn_frontdoor_profile_id = var.frontdoor_id
}