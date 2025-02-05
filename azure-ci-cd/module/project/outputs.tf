output "project_id" {
  value = azuredevops_project.project.id
}

output "github_service_connection" {
  value = azuredevops_serviceendpoint_github.github.id
}

output "environment" {
  value = azuredevops_environment.environment.name
}