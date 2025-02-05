resource "databricks_library" "python_library" {
  cluster_id = var.cluster_id
  pypi {
    package = var.package_name
    // repo can also be specified here
  }
}