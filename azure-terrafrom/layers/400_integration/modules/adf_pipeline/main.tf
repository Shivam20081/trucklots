resource "azurerm_data_factory_pipeline" "adf_pipeline" {
  name            = "GS-${var.Env}-adf-${var.tenant}"
  data_factory_id = var.data_factory_id

  activities_json = jsonencode([
    for activity in var.notebook_activities :
    {
      name = activity.name
      type = activity.type
      linkedServiceName = {
        referenceName = activity.link_name
      }
      typeProperties = {
        rootPath     = activity.rootPath
        notebookPath = activity.notebookPath
        baseParameters = merge(activity.dynamic_base_parameters)
          
      }
      dependsOn = activity.depends_on == null ? null : [
        for dep in split(",", activity.depends_on_resource) : {
            activity           = dep
            dependencyConditions = [activity.depends_on]
        }
      ]
    }
  ])
}