resource "azuredevops_project" "project" {
  name               = "GS-${var.Env}"
  visibility         = "private"
  version_control    = "Git"
  work_item_template = "Agile"
}

resource "azuredevops_serviceendpoint_github" "github" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "Github Service Endpoint"

  auth_personal {
    personal_access_token = var.github_token 
  }
}

resource "azuredevops_environment" "environment" {
  project_id = azuredevops_project.project.id
  name       = upper(var.Env)
}

resource "azuredevops_serviceendpoint_azurerm" "service_endpoint" {
  project_id                             = azuredevops_project.project.id
  service_endpoint_name                  = "Azure Service Manager Endpoint"
  azurerm_spn_tenantid                   = var.tenant_id
  azurerm_subscription_id                = var.subscription_id
  azurerm_subscription_name              = var.subscription_name
}

resource "azuredevops_serviceendpoint_sonarqube" "sonar_service_endpoint" {
  project_id            = azuredevops_project.project.id
  service_endpoint_name = "Sonar Service Connection"
  url                   = "http://52.151.197.41:9000/"
  token                 = var.sonar_token
  description           = "Service Connection for SonarQube"
}

resource "azuredevops_serviceendpoint_azurecr" "acr_endpoint" {
  project_id                             = azuredevops_project.project.id
  service_endpoint_name                  = "Container Registry Endpoint"
  resource_group                         = "GREENSIGHT-${upper(var.Env)}-BACKEND"
  azurecr_spn_tenantid                   = var.tenant_id
  azurecr_name                           = var.acr_name
  azurecr_subscription_id                = var.subscription_id
  azurecr_subscription_name              = var.subscription_name
}