# 600_backend

# output "function_app_name1" {
#   value = module.azure_function_app.function_app_name[0]
# }

# output "function_app_name2" {
#   value = module.azure_function_app.function_app_name[1]
# }

# output "function_app_chatbot" {
#   value = module.chatbot_functionapp.name
# }

output "acr_name" {
  value = module.container_registry_001.admin_username
}

output "acr_password" {
  value = module.container_registry_001.admin_password
  sensitive = true
}

output "container_app_name" {
  value = module.container_app_001.name
}