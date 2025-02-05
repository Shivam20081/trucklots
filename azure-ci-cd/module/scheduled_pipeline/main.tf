resource "azuredevops_build_definition" "scheduled_pipeline" {
  project_id = var.project_id 
  name       = "${var.Env}-GreenSight-${var.app_suite} (${var.tech})"
  path       = "\\"

  ci_trigger {
    use_yaml = var.trigger
  }

  schedules {
    
    branch_filter {
      include = [var.github_branch]
    }

    days_to_build              = var.days_to_build
    schedule_only_with_changes = false
    start_hours                = var.starting_hours
    start_minutes              = var.starting_min
    time_zone                  = "(UTC+05:30) Chennai, Kolkata, Mumbai, New Delhi"
  }

 repository {
    repo_type             = "GitHub"
    repo_id               = var.github_repo
    branch_name           = var.github_branch
    yml_path              = var.ymlpath
    service_connection_id = var.service_connection_id
  }

  dynamic "variable" {
    for_each = var.environment_variable
    content {
      name  = variable.value.name
      value = variable.value.secret_value
    }
  }
}