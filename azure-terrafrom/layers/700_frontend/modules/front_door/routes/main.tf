resource "azurerm_cdn_frontdoor_route" "routes" {
  name                          = "gsfrontdoor${var.Env}route${var.counts}"
  cdn_frontdoor_endpoint_id     = var.endpoint_id
  cdn_frontdoor_origin_group_id = var.origin_group_id
  cdn_frontdoor_origin_ids      = var.origin_ids
  cdn_frontdoor_rule_set_ids    = var.rule_set_ids
  enabled                       = true

  forwarding_protocol    = "HttpsOnly"
  https_redirect_enabled = true
  patterns_to_match      = ["/*"]
  supported_protocols    = ["Http", "Https"]
  
  cdn_frontdoor_custom_domain_ids = var.custom_domain ? [var.custom_domain_id] : null
  
  cache {
    query_string_caching_behavior = "IgnoreQueryString"
    compression_enabled           = true
    content_types_to_compress     = ["application/eot", "application/font", "application/font-sfnt","application/javascript", "application/json", "application/opentype", "application/otf", "application/pkcs7-mime","application/truetype","application/ttf","application/vnd.ms-fontobject","application/xhtml+xml","application/xml","application/xml+rss","application/x-font-opentype","application/x-font-truetype","application/x-font-ttf","application/x-httpd-cgi","application/x-javascript","application/x-mpegurl","application/x-opentype","application/x-otf","application/x-perl","application/x-ttf","font/eot","font/ttf","font/otf","font/opentype","image/svg+xml","text/css","text/csv","text/html","text/javascript","text/js","text/plain","text/richtext","text/tab-separated-values","text/xml","text/x-script","text/x-component","text/x-java-source"]
  }
}