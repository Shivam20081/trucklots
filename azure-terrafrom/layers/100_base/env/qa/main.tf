# 100_base

module "virtual_network" {
  source          = "../../modules/v_net"
  cidr_v_net      = "10.0.0.0/16"
  Env             = var.Env
  rg_name         = var.rg_name
  counts          = "001"
}

module "private_link_subnet" {
  source          = "../../modules/subnet"
  Env             = var.Env
  subnet_name     = "private-link"
  subnet_cidr     = "10.0.1.0/24"
  v_net_name      = module.virtual_network.v_net_name
  rg_name         = var.rg_name
  delegation      = false

  depends_on = [ module.virtual_network ]
}

module "container_app_subnet" {
  source          = "../../modules/subnet"
  Env             = var.Env
  subnet_name     = "container-app"
  subnet_cidr     = "10.0.2.0/24"
  v_net_name      = module.virtual_network.v_net_name
  rg_name         = var.rg_name
  delegation      = "container_app"

  depends_on = [ module.virtual_network ]
}

module "databrick_public_subnet" {
  source                = "../../modules/subnet"
  Env                   = var.Env
  subnet_name           = "databrick-public"
  subnet_cidr           = "10.0.4.0/28"
  v_net_name            = module.virtual_network.v_net_name
  rg_name               = var.rg_name
  delegation            = "databricks"
  
  depends_on = [ module.virtual_network ]
}

module "databrick_private_subnet" {
  source          = "../../modules/subnet"
  Env             = var.Env
  subnet_name     = "databrick-private"
  subnet_cidr     = "10.0.5.0/28"
  v_net_name      = module.virtual_network.v_net_name
  rg_name         = var.rg_name
  delegation      = "databricks"
  
  depends_on      = [ module.virtual_network ]
}

module "key_vault" {
  source          = "../../modules/key_vault"
  rg_location     = var.rg_location
  rg_name         = var.rg_name
  Env             = var.Env
  tenant_id       = data.azurerm_client_config.current.tenant_id
  object_id       = data.azurerm_client_config.current.object_id
}

module "private_DNS_zone" {
  source          = "../../../../modules/DNS_module/private_DNS_zone" 
  rg_name         = var.rg_name
  Env             = var.Env
}

module "virtual_network_link_private_DNS" {
  source          = "../../../../modules/DNS_module/link_v_net"
  DNS_name        = module.private_DNS_zone.name
  vnet_id         = module.virtual_network.id
  auto_registration = false
  rg_name         = var.rg_name
  Env             = var.Env
}

module "virtual_network_link_private_DNS_databrick" {
  source          = "../../../../modules/DNS_module/link_v_net"
  DNS_name        = module.private_DNS_zone.databrick_dns_name
  vnet_id         =  module.virtual_network.id
  auto_registration = false
  rg_name         = var.rg_name
  Env             = var.Env
}


module "security_group" {
  source              = "../../modules/security_group/security_group"
  Env                 = var.Env
  rg_location         = var.rg_location
  rg_name             = var.rg_name
  counts              = "001"
}

module "attach_subnet_with_security_group_public" {
  source              = "../../modules/security_group/associate_security_group"
  subnet_id           = module.databrick_public_subnet.subnet_id
  security_group_id   = module.security_group.id
}

module "attach_subnet_with_security_group_private" {
  source              = "../../modules/security_group/associate_security_group"
  subnet_id           = module.databrick_private_subnet.subnet_id
  security_group_id   = module.security_group.id
}

module "custom_role" {
  source              = "../../modules/role_definitions"
  subscription_id     = var.subscription_id
}

module "log_analytics" {
  source              = "../../modules/log_analytics"
  Env                 = var.Env
  rg_name             = var.rg_name
  rg_location         = var.rg_location
  counts              = "001"
}

module "action_group" {
  source            = "../../modules/action_group"
  Env               = var.Env
  rg_name           = var.rg_name
  counts            = "001"
  email             = [
    {
      reciver_name  = "Vikrant"
      reciver_email = "vikrant@seasiainfotech.com"
    },
    {
      reciver_name  = "Ashish"
      reciver_email = "gosainashish@seasiainfotech.com"
    },
    {
      reciver_name  = "Paramveer"
      reciver_email = "singhparamveer@seasiainfotech.com"
    },
    {
      reciver_name  = "Harpreet"
      reciver_email = "singhharpreet2@seasiainfotech.com"
    },
    {
      reciver_name  = "Shivani"
      reciver_email = "sainishivani@seasiainfotech.com"
    }
  ]
}

module "app_registration_adf" {
  source        = "../../modules/app_registions"
  Env           = var.Env
  counts        = "001"
  object_id     = data.azurerm_client_config.current.object_id
  key_vault_id  = module.key_vault.id 
}