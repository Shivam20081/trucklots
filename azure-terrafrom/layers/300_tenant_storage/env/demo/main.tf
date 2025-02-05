# 300_tenant_storage

module "storage" {
  source          = "../../modules/storage_account"
  Env             = var.Env
  rg_name         = var.rg_name
  counts          = "001"
  frontend_url    = "https://demo.greensight.ai"
  key_vault_id    = data.terraform_remote_state.base.outputs.key_vault_id
  static_website  = true 
}

########################### Comman-Containers ################################

module "logs_container" {
  source            = "../../modules/container"
  container_name    = "logs"
  storage_name      = module.storage.storage_account_name

  depends_on = [ module.storage ]
}

module "appdata_container" {
  source            = "../../modules/container"
  container_name    = "appdata"
  storage_name      = module.storage.storage_account_name

  depends_on = [ module.storage ]
}

module "infra_container" {
  source          = "../../modules/container"
  container_name  = "infra"
  storage_name    = module.storage.storage_account_name

  depends_on = [ module.storage ]
}

module "cdn_container" {
  source            = "../../modules/container"
  container_name    = "static-content"
  container_type    = "container"
  storage_name      = module.storage.storage_account_name
  depends_on        = [ module.storage ]
}

module "acme_container" {
  source            = "../../modules/container"
  container_name    = "acme-container"
  container_type    = "container"
  storage_name      = module.storage.storage_account_name
  depends_on        = [ module.storage ]
}


################################################################################

################################ Lifecycle policy ###########################

module "logs_lifecycle" {
  source              = "../../modules/lifecycle"
  storage_account_id  = module.storage.storage_account_id
  dynamic_rules       = var.dynamic_rules

  depends_on = [ module.logs_container ]
}

#  UPDATE VARIABLE (dynamic_rules) FOR ANY CHANGES IN POLICY OR NEW POLICY 
#############################################################################

module "cdn_profile" {
  source            = "../../modules/cdn/profile"
  counts            = "001"
  Env               = var.Env
  rg_name           = var.rg_name
}

module "cdn_endpoint" {
  source            = "../../modules/cdn/endpoint"
  counts            = "001"
  Env               = var.Env
  rg_name           = var.rg_name
  host              = "${module.storage.storage_account_name}.blob.core.windows.net"
  cdn_name          = module.cdn_profile.name 
  frontend_url      = "https://demo.greensight.ai" 
  content_type      = "json"
  origin_path       = "/static-content"

}

module "cdn_endpoint_automation_report" {
  source            = "../../modules/cdn/endpoint"
  counts            = "002"
  Env               = var.Env
  rg_name           = var.rg_name
  host              = "${module.storage.storage_account_name}.z13.web.core.windows.net"
  cdn_name          = module.cdn_profile.name 
  content_type      = "report"
}

module "automation_report_domain" {
  source            = "../../modules/cdn/domain"
  Env               = var.Env
  counts            = "001"
  endpoint_id       = module.cdn_endpoint_automation_report.id
  custom_domain     = "demo-report.greensight.ai"
}

