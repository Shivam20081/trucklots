# 300_tenant_storage

module "storage" {
  source            = "../../modules/storage_account"
  Env               = var.Env
  rg_name           = var.rg_name
  counts            = "001"
  frontend_url      = "https://app-qa.greensight.ai" 
  key_vault_id      = data.terraform_remote_state.base.outputs.key_vault_id
  static_website    = false 
}

module "private_endpoint" {
  source                        = "../../../../modules/endpoint_module"
  rg_name                       = var.rg_name
  rg_location                   = var.rg_location
  subnet_id                     = data.terraform_remote_state.base.outputs.private_link_subnet_id
  link_name                     = module.storage.storage_account_name
  pe_resource_id                = module.storage.storage_account_id
  Env                           = var.Env
  subresource_name              = var.subresource_name
  private_dns_zone_group        = false
}

module "logs_container" {
  source            = "../../modules/container"
  container_name    = "logs"
  storage_name      = module.storage.storage_account_name

  depends_on        = [ module.storage ]
}

module "appdata_container" {
  source            = "../../modules/container"
  container_name    = "appdata"
  storage_name      = module.storage.storage_account_name

  depends_on        = [ module.storage ]
}

module "infra_container" {
  source            = "../../modules/container"
  container_name    = "infra"
  storage_name      = module.storage.storage_account_name

  depends_on        = [ module.storage ]
}

module "cdn_container" {
  source            = "../../modules/container"
  container_name    = "static-content"
  container_type    = "container"
  storage_name      = module.storage.storage_account_name
  depends_on        = [ module.storage ]
}

module "pilot_container" {
  source              = "../../modules/container"
  container_name      = "pilot-container"
  storage_name        = module.storage.storage_account_name

  depends_on          = [ module.storage ]
}

module "adm_container" {
  source              = "../../modules/container"
  container_name      = "adm-container"
  storage_name        = module.storage.storage_account_name

  depends_on          = [ module.storage ]
}

module "schneider_container" {
  source              = "../../modules/container"
  container_name      = "schneider-container"
  storage_name        = module.storage.storage_account_name

  depends_on          = [ module.storage ]
}

module "lowes_container" {
  source              = "../../modules/container"
  container_name      = "lowes-container"
  storage_name        = module.storage.storage_account_name

  depends_on          = [ module.storage ]
}

module "pepsi_container" {
  source              = "../../modules/container"
  container_name      = "pepsi-container"
  storage_name        = module.storage.storage_account_name
  depends_on          = [ module.storage ]
}

module "pepsico_container" {
  source              = "../../modules/container"
  container_name      = "pepsico-container"
  storage_name        = module.storage.storage_account_name
  depends_on          = [ module.storage ]
}


module "logs_lifecycle" {
  source              = "../../modules/lifecycle"
  storage_account_id  = module.storage.storage_account_id
  dynamic_rules       = var.dynamic_rules

  depends_on          = [ module.adm_container, module.logs_container, module.lowes_container, module.pilot_container, module.schneider_container ]
}

module "cdn_profile" {
  source            = "../../modules/cdn/profile"
  counts            = "001"
  Env               = var.Env
  rg_name           = var.rg_name
}

module "cdn_endpoint" {
  source = "../../modules/cdn/endpoint"
  counts            = "001"
  Env               = var.Env
  rg_name           = var.rg_name
  host              = "${module.storage.storage_account_name}.blob.core.windows.net"
  cdn_name          = module.cdn_profile.name 
  frontend_url      = "https://app-qa.greensight.ai"
  content_type      = "json"
  origin_path       = "/static-content"
}

################################### MONITRING #################################

module "blob_diagnostic" {
  source              = "../../../../modules/diagnostic"
  Env                 = var.Env
  counts              = "001"
  target_id           = "${module.storage.storage_account_id}/blobServices/default"
  storage_account_id  = null
  log_analytics_id    = data.terraform_remote_state.base.outputs.log_analytics_id
}

################################### ALERTS ####################################

module "alert_ingress" {
  source            = "../../../../modules/alerts/common_alerts"
  Env               = var.Env
  counts            = "001"
  rg_name           = var.rg_name
  resource_name     = "storage"
  severity          = 3
  resource_id       = "${module.storage.storage_account_id}/blobServices/default"
  action_group_id   = data.terraform_remote_state.base.outputs.action_group_id
  description       = "Storage account gets a new file size gretter then 500mb."
  metric_name       = "ingress"
  metric_namespace  = "Microsoft.Storage/storageAccounts/blobservices"
  aggregation       = "Total"
  threshold         = 524288000  # 500mb
  operator          = "GreaterThanOrEqual"
}

module "alert_unwanted_files_tenant" {
  source            = "../../../../modules/alerts/custom_alerts"
  Env               = var.Env
  counts            = "001"
  rg_location       = var.rg_location
  rg_name           = var.rg_name
  auto_resolve      = true
  log_analytics_id  = data.terraform_remote_state.base.outputs.log_analytics_id
  action_group_id   = data.terraform_remote_state.base.outputs.action_group_id
  description       = "Unwanted file found in tenant Storage container (Lowes, adm, Pepsi, Pilot) on ${upper(var.Env)} environment."
  severity          = 2
  query             = <<-QUERY
                      StorageBlobLogs 
                        | where Category == 'StorageWrite' and OperationName == 'PutBlob' 
                        | where (ObjectKey contains '/greensightqastorage/lowes-container' or 
                          ObjectKey contains '/greensightqastorage/pepsi-container' or 
                          ObjectKey contains '/greensightqastorage/adm-container' or 
                          ObjectKey contains '/greensightqastorage/pilot-container')
                        | where not(ObjectKey contains '.csv' or 
                          ObjectKey contains '.xlsx' or
                          ObjectKey contains '.log' or
                          ObjectKey contains 'index.txt')
                      QUERY
}

module "alert_unwanted_files_appdata" {
  source            = "../../../../modules/alerts/custom_alerts"
  Env               = var.Env
  counts            = "002"
  rg_location       = var.rg_location
  rg_name           = var.rg_name
  auto_resolve      = true
  log_analytics_id  = data.terraform_remote_state.base.outputs.log_analytics_id
  action_group_id   = data.terraform_remote_state.base.outputs.action_group_id
  description       = "Unwanted file found in appdata Storage container on ${upper(var.Env)} environment."
  severity          = 2
  query             = <<-QUERY
                      StorageBlobLogs 
                      | where Category == 'StorageWrite' and OperationName == 'PutBlob'
                      | where (ObjectKey contains "/greensightqastorage/appdata")
                      | where not(ObjectKey contains ".gif" or 
                        ObjectKey contains ".jpeg" or 
                        ObjectKey contains ".png" or 
                        ObjectKey contains ".jpg" or
                        ObjectKey contains ".svg") 
                      QUERY
}