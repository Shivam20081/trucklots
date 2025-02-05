resource "azurerm_cdn_endpoint_custom_domain" "custom_domain" {
  name                      = "GS-cdn-domain-${var.Env}-global-${var.counts}"
  cdn_endpoint_id           = var.endpoint_id
  host_name                 = var.custom_domain
  cdn_managed_https{
    certificate_type        = "Dedicated" 
    protocol_type           = "ServerNameIndication"
  }
}
