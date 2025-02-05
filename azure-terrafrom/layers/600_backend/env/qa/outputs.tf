# 600_backend

output "funciton_app_001_name" {
  value = module.funciton_app_001.name
}

output "funciton_app_002_name" {
  value = module.funciton_app_002.name
}

output "funciton_app_003_name" {
  value = module.funciton_app_003.name
}

output "funciton_app_004_name" {
  value = module.funciton_app_004.name
}

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