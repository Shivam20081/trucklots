# 100_base

output "private_link_subnet_name" {
  value = module.private_link_subnet.subnet_name
}

output "application_gateway_subnet_name" {
  value = module.application_gateway_subnet.subnet_name
}


output "virtual_network_name" {
  value = module.virtual_network.v_net_name
}

output "virtual_network_id" {
  value = module.virtual_network.id
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

output "application_gateway_subnet_id" {
  value = module.application_gateway_subnet.subnet_id
}

output "DNS_zone_id" {
  value = module.private_DNS_zone.id
}

output "public_ip_id" {
  value = module.public_ip.public_ip
}

output "identity_id" {
  value = module.key_vault.identity_id
}

output "log_analytics_id" {
  value = module.log_analytics.id
}

output "action_group_id" {
  value = module.action_group.id
}

output "ip" {
  value = module.public_ip.ip
  sensitive = true
}