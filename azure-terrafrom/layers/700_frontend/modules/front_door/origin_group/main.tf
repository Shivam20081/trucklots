resource "azurerm_cdn_frontdoor_origin_group" "origin_group" {
  name                     = "gs-${var.Env}-origingroup-${var.counts}"
  cdn_frontdoor_profile_id = var.frontdoor_id

  load_balancing {
    additional_latency_in_milliseconds = 0
    sample_size                        = 16
    successful_samples_required        = 3
  }
}
