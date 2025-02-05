# 600_backend

output "function_app_name1" {
  value = module.azure_function_app.function_app_name[0]
}

output "function_app_name2" {
  value = module.azure_function_app.function_app_name[1]
}

output "research_function" {
  value = module.azure_research_function_app.function_app_name_single_region
}
