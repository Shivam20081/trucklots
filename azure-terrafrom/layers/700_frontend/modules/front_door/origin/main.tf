resource "azurerm_cdn_frontdoor_origin" "origin" {
  name                          = "gs-frontdoor-${var.Env}-origin-${var.counts}"
  cdn_frontdoor_origin_group_id = var.origin_group_id
  enabled                       = true

  certificate_name_check_enabled = true

  host_name          = lower(var.host_name)
  https_port         = 443
  origin_host_header = var.host_name
  priority           = 1
  weight             = 1

  dynamic "private_link" {
    for_each = var.enable_private_link == true ? [1] : []
        content {
        request_message        = "Request access for Private Link Origin CDN Frontdoor"
        target_type            = "sites"
        location               = "eastus"
        private_link_target_id = var.host_id
    }
  }
}