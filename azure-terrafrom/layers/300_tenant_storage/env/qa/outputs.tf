# 300_tenant_storage

output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "storage_account_id" {
  value = module.storage.storage_account_id
}

output "storage_primary_access_key" {
  value  = module.storage.storage_primary_access_key
  sensitive = true
}

output "storage_account_endpoint" {
  value = module.storage.endpoint
}

output "cdn_endpoint" {
  value = module.cdn_endpoint.endpoint
}