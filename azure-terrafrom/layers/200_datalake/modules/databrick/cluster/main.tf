resource "databricks_cluster" "cluster" {
  cluster_name            = "Greensight-${var.Env}-cluster"
  spark_version           = var.spark_version #"12.2.x-scala2.12" #data.databricks_spark_version.latest_lts.id
  node_type_id            = var.node_type #data.databricks_node_type.smallest.id
  autotermination_minutes = 120
  num_workers             = 1
  runtime_engine          = "PHOTON"
}

resource "databricks_token" "pat" {
  comment  = "PAT token for QA piepline"

  depends_on = [ databricks_cluster.cluster ]
}

resource "azurerm_key_vault_secret" "databrick_token" {
  name         = "databrick-${var.Env}-token"
  value        = databricks_token.pat.token_value
  key_vault_id = var.key_vault_id

  depends_on = [ databricks_token.pat ]
}


