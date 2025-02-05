# 700_frontend

module "static_web_app" {
  source    = "../../modules/static_web_module"
  Env       = var.Env
  rg_name   = var.rg_name
  counts    = "001"
  sku       = "Free"
}

module "frontdoor_profile" {
  source        = "../../modules/front_door/frontdoor_profile"
  Env           = var.Env
  counts        = "001"
  sku_name      = "Standard_AzureFrontDoor"
  timeout       = 240
  rg_name       = var.rg_name
  certificate_id = data.azurerm_key_vault_certificate.greensight_certificate.secret_id
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

  depends_on = [ module.frontdoor_profile, module.frontdoor_endpoint_001, module.frontdoor_origin_001, module.frontdoor_rule_set_001, module.frontdoor_origin_group_001 ]
}
