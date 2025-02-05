# 100_base

module "virtual_network" {
  source      = "../../modules/v_net"
  cidr_v_net  = "10.0.0.0/16"
  Env         = var.Env
  rg_name     = var.rg_name
  counts      = "001"
}

module "private_link_subnet" {
  source            = "../../modules/subnet"
  Env               = var.Env 
  subnet_name       = "private-link"
  subnet_cidr       = "10.0.1.0/24"
  v_net_name        = module.virtual_network.v_net_name
  rg_name           = var.rg_name
  delegation        = false

  depends_on        = [ module.virtual_network ]

}

module "application_gateway_subnet" {
  source            = "../../modules/subnet"
  Env               = var.Env 
  subnet_name       = "application-gateway"
  subnet_cidr       = "10.0.2.0/24"
  v_net_name        = module.virtual_network.v_net_name
  rg_name           = var.rg_name
  delegation        = false

  depends_on        = [ module.virtual_network ]

}


module "private_DNS_zone" {
  source            = "../../../../modules/DNS_module/private_DNS_zone" 
  rg_name           = var.rg_name
  Env               = var.Env 
}

module "virtual_network_link_private_DNS" {
  source            = "../../../../modules/DNS_module/link_v_net"
  Env               = var.Env 
  DNS_name          = module.private_DNS_zone.name
  vnet_id           = module.virtual_network.id
  auto_registration = false
  rg_name           = var.rg_name
}

module "public_ip" {
  source          = "../../modules/public_ip"
  Env             = var.Env
  rg_location     = var.rg_location 
  rg_name         = var.rg_name
}

module "key_vault" {
  source          = "../../modules/key_vault"
  rg_location     = var.rg_location
  rg_name         = var.rg_name
  Env             = var.Env
  tenant_id       = data.azurerm_client_config.current.tenant_id
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