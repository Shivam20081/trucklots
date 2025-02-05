# 700_frontend

output "Static_web_app_name" {
  value = "Static web app name for Frontend QA --> ${module.static_web_app.name} "
}

# output "Application_gateway_name" {
#   value = "Application Gateway for Frontend QA --> ${module.static_web_app.name} "
# }

output "webapp_token" {
  value = module.static_web_app.web_app_token
  sensitive = true
}

output "frontdoor_profile" {
  value = module.frontdoor_profile.resource_guid
}

# output "cdn" {
#   value = data.azuread_service_principal.frontdoor.object_id
# }