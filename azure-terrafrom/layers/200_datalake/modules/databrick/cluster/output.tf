output "cluster_id" {
  value = databricks_cluster.cluster.cluster_id
}

output "access_token" {
  value = databricks_token.pat.token_value
  sensitive = true
}