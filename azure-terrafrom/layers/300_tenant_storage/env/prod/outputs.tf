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

output "cdn_endpoint" {
  value = module.cdn_endpoint.endpoint
}

output "cdn_endpoint_automation_report" {
  value = module.cdn_endpoint_automation_report.endpoint
}

output "static_website_url" {
  value = module.storage.static_website_url
}