resource "azurerm_cdn_frontdoor_custom_domain" "custom_domain" {
  name                     = "GS-fcd-domain-${var.Env}-eastus-${var.Env}"
  cdn_frontdoor_profile_id = var.frontdoor_id
  host_name                = var.domain

  tls {
    certificate_type    = "CustomerCertificate"
    cdn_frontdoor_secret_id = var.secret_id
  }
}

resource "azurerm_cdn_frontdoor_custom_domain_association" "domain_association" {
  cdn_frontdoor_custom_domain_id = azurerm_cdn_frontdoor_custom_domain.custom_domain.id
  cdn_frontdoor_route_ids        = [var.route_id]
}