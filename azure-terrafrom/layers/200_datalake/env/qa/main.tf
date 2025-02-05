# 200_datalake

module "azure_data_factory" {
  source            = "../../modules/data_factory"
  Env               = var.Env
  rg_location       = var.rg_location
  rg_name           = var.rg_name
  counts            = "001"
  workspace_url     = module.databrick.workspace_url
  cluster_id        = module.databrick_cluster.cluster_id
  access_token      = module.databrick_cluster.access_token
}

module "role_datafactory" {
  source            = "../../../../modules/access_control/assign_role"
  permission        = "Data Factory Contributor"
  resource_id       = module.azure_data_factory.data_factory_id
  object_id         = data.terraform_remote_state.base.outputs.app_object_id
}

module "databrick" {
  source          = "../../modules/databrick/workspace"
  Env             = var.Env
  counts          = "001"
  rg_location     = var.rg_location
  rg_name1        = var.rg_name
  rg_name2        = var.rg_name_secondary
  databrick_public_subnet_name          = data.terraform_remote_state.base.outputs.databrick_public_subnet_name
  databrick_private_subnet_name         = data.terraform_remote_state.base.outputs.databrick_private_subnet_name
  virtual_network_id                    = data.terraform_remote_state.base.outputs.virtual_network_id
  public_subnet_network_security_group  = data.terraform_remote_state.base.outputs.security_group_id_public
  private_subnet_network_security_group = data.terraform_remote_state.base.outputs.security_group_id_private
  storage_account_name                  = "${var.Env}databrickstorage"
  storage_sku                           = "Standard_GZRS"
}

module "workspace_api_endpoint" {
  source            = "../../../../modules/endpoint_module"
  Env               = var.Env
  rg_location       = var.rg_location
  rg_name           = var.rg_name
  subnet_id         = data.terraform_remote_state.base.outputs.private_link_subnet_id
  link_name         = "databrick-api"
  pe_resource_id    = module.databrick.workspace_id
  subresource_name  = ["databricks_ui_api"]
  DNS_id            = data.terraform_remote_state.base.outputs.databrick_dns_id
  DNS_zone_name     = data.terraform_remote_state.base.outputs.databrick_dns_id

  depends_on        = [ module.databrick ]
}

module "workspace_browser_endpoint" {
  source            = "../../../../modules/endpoint_module"
  Env               = var.Env
  rg_location       = var.rg_location
  rg_name           = var.rg_name
  subnet_id         = data.terraform_remote_state.base.outputs.private_link_subnet_id
  link_name         = "databrick-browser"
  pe_resource_id    = module.databrick.workspace_id
  subresource_name  = ["browser_authentication"]
  DNS_id            = data.terraform_remote_state.base.outputs.databrick_dns_id
  DNS_zone_name     = data.terraform_remote_state.base.outputs.databrick_dns_id

  depends_on        = [ module.databrick, module.workspace_api_endpoint  ]
}

module "databrick_cluster" {
  source            = "../../modules/databrick/cluster"
  Env               = var.Env
  node_type         = "Standard_DS3_v2"
  spark_version     = "12.2.x-scala2.12"
  key_vault_id      = data.terraform_remote_state.base.outputs.key_vault_id
  depends_on        = [ module.databrick]
}

module "pypi_pandas" {
  source            = "../../modules/databrick/library"
  cluster_id        = module.databrick_cluster.cluster_id
  package_name      = "pandas"
}

module "pypi_azure_identity" {
  source            = "../../modules/databrick/library"
  cluster_id        = module.databrick_cluster.cluster_id
  package_name      = "azure-identity"
}

module "pypi_azure_keyvault" {
  source            = "../../modules/databrick/library"
  cluster_id        = module.databrick_cluster.cluster_id
  package_name      = "azure-keyvault"
}

module "pypi_azure_storage" {
  source            = "../../modules/databrick/library"
  cluster_id        = module.databrick_cluster.cluster_id
  package_name      = "azure-storage"
}

module "pypi_openpyxl" {
  source            = "../../modules/databrick/library"
  cluster_id        = module.databrick_cluster.cluster_id
  package_name      = "openpyxl"
}

module "pypi_pymysql" {
  source            = "../../modules/databrick/library"
  cluster_id        = module.databrick_cluster.cluster_id
  package_name      = "pymysql"
}

module "pypi_pyodbc" {
  source            = "../../modules/databrick/library"
  cluster_id        = module.databrick_cluster.cluster_id
  package_name      = "pyodbc"
}

module "pypi_sqlalchemy" {
  source            = "../../modules/databrick/library"
  cluster_id        = module.databrick_cluster.cluster_id
  package_name      = "sqlalchemy"
}

module "pypi_xlsxwriter" {
  source            = "../../modules/databrick/library"
  cluster_id        = module.databrick_cluster.cluster_id
  package_name      = "xlsxwriter"
}