# # 700_frontend

output "Static_web_app_name" {
  value = module.static_web_app.name
}

output "webapp_token" {
  value = module.static_web_app.web_app_token
  sensitive = true
}