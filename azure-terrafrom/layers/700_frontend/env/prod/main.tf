# 700_frontend

module "static_web_app" {
  source      = "../../modules/static_web_module"
  Env         = var.Env
  rg_name     = var.rg_name
  counts      = "001"
  sku         = "Free"
}

module "frontdoor_profile" {
  source        = "../../modules/front_door/frontdoor_profile"
  Env           = var.Env
  counts        = "001"
  sku_name      = "Premium_AzureFrontDoor"
  timeout       = 240
  rg_name       = var.rg_name
  certificate_id = data.azurerm_key_vault_certificate.greensight_certificate.id
  identity_id   = data.terraform_remote_state.base.outputs.identity_id  
}

module "frontdoor_origin_group_001" {
  source        = "../../modules/front_door/origin_group"
  Env           = var.Env
  counts        = "001"
  frontdoor_id  = module.frontdoor_profile.id

  depends_on    = [ module.frontdoor_profile ]
}

module "frontdoor_origin_001" {
  source              = "../../modules/front_door/origin"
  Env                 = var.Env
  counts              = "001"
  origin_group_id     = module.frontdoor_origin_group_001.id
  host_name           = module.static_web_app.default_DNS_name
  enable_private_link = false

  depends_on          = [ module.frontdoor_profile, module.frontdoor_origin_group_001 ]
}

module "frontdoor_endpoint_001" {
  source              = "../../modules/front_door/endpoint"
  Env                 = var.Env
  counts              = "001"
  frontdoor_id        = module.frontdoor_profile.id

  depends_on          = [ module.frontdoor_profile ]
}

module "frontdoor_rule_set_001" {
  source              = "../../modules/front_door/rule_set"
  Env                 = var.Env
  counts              = "001"
  frontdoor_id        = module.frontdoor_profile.id

  depends_on          = [ module.frontdoor_profile ]
}

module "frontdoor_routes_001" {
  source              = "../../modules/front_door/routes"
  Env                 = var.Env
  counts              = "001"
  endpoint_id         = module.frontdoor_endpoint_001.id
  origin_group_id     = module.frontdoor_origin_group_001.id
  origin_ids          = [module.frontdoor_origin_001.id]
  rule_set_ids        = [module.frontdoor_rule_set_001.id]
  custom_domain       = true
  custom_domain_id    = module.domain.id

  depends_on = [ module.frontdoor_profile, module.frontdoor_endpoint_001, module.frontdoor_origin_001, module.frontdoor_rule_set_001, module.frontdoor_origin_group_001 ]
}

module "domain" {
  source          = "../../modules/front_door/custom_domain"
  counts          = "001"
  Env             = var.Env
  domain          = "act.greensight.ai"
  frontdoor_id    = module.frontdoor_profile.id
  secret_id       = module.frontdoor_profile.secret_id
  route_id        = module.frontdoor_routes_001.id
}


module "frontdoor_firewall" {
  source            = "../../modules/firewall"
  Env               = var.Env
  counts            = "001"
  sku_name          = "Premium_AzureFrontDoor"
  rg_name           = var.rg_name
  custom_domain_id  = module.domain.id
  profile_id        = module.frontdoor_profile.id

  depends_on = [ module.frontdoor_profile, module.domain ]
}

################################################## MONITRING ###########################################

module "diagnostic_settings_001" {
  source              = "../../../../modules/diagnostic"
  Env                 = var.Env
  counts              = "001"
  target_id           = module.frontdoor_profile.id
  storage_account_id  = data.terraform_remote_state.tenant_storage.outputs.storage_account_id
  log_analytics_id    = data.terraform_remote_state.base.outputs.log_analytics_id
}

#################################################### ALERTS ##############################################

module "alert_001" {
  source            = "../../../../modules/alerts/common_alerts"
  Env               = var.Env
  counts            = "001"
  rg_name           = var.rg_name
  resource_name     = "frontdoor"
  severity          = 2
  resource_id       = module.frontdoor_profile.id
  action_group_id   = data.terraform_remote_state.base.outputs.action_group_id
  description       = "Request count is greater then 300 on ${upper(var.Env)} Frontend"
  metric_name       = "RequestCount"
  metric_namespace  = "Microsoft.Cdn/profiles"
  aggregation       = "Average"
  threshold         = 300
  operator          = "GreaterThan"
}