# 100_base

output "private_link_subnet_name" {
  value = module.private_link_subnet.subnet_name
}

output "container_app_subnet_name" {
  value = module.container_app_subnet.subnet_name
}

output "databrick_public_subnet_name" {
  value = module.databrick_public_subnet.subnet_name
}

output "databrick_private_subnet_name" {
  value = module.databrick_private_subnet.subnet_name
}

output "virtual_network_name" {
  value = module.virtual_network.v_net_name
}

output "virtual_network_id" {
  value = module.virtual_network.id
}

output "security_group_id_public" {
  value = module.attach_subnet_with_security_group_public.id
}

output "security_group_id_private" {
  value = module.attach_subnet_with_security_group_private.id
}

output "key_vault_name" {
  value = module.key_vault.name
}

output "private_link_subnet_id" {
  value = module.private_link_subnet.subnet_id
}

output "key_vault_id" {
  value = module.key_vault.id
}

output "container_app_subnet_id" {
  value = module.container_app_subnet.subnet_id
}


output "DNS_zone_id" {
  value = module.private_DNS_zone.id
}

# output "public_ip_id" {
#   value = module.public_ip.public_ip
# }

output "identity_id" {
  value = module.key_vault.identity_id
}

output "databrick_dns_id" {
  value = module.private_DNS_zone.databrick_dns_id
}

output "databrick_dns_name" {
  value = module.private_DNS_zone.databrick_dns_name
}

output "log_analytics_id" {
  value = module.log_analytics.id
}

output "action_group_id" {
  value = module.action_group.id
}

output "client_id" {
  value = module.app_registration_adf.client_id
}

output "client_secret" {
  value = module.app_registration_adf.client_secret
  sensitive = true
}

output "app_object_id" {
  value = module.app_registration_adf.sp_id
}