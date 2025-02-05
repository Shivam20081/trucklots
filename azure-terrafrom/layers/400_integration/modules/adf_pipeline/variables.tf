variable "notebook_activities" {
  description = "List of Databricks Notebook activities to create"
  type        = list(object({
    name           = string
    type           = string
    link_name      = string
    rootPath       = string
    notebookPath   = string
    depends_on     = optional(string)
    depends_on_resource = optional(string)
    dynamic_base_parameters = optional(map(object({
      value = string
      type  = string
    })))

  }))
}

variable "data_factory_id" {
  type = string
}

variable "tenant" {
  type = string
}

variable "Env" {
  type = string
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat","demo"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}
