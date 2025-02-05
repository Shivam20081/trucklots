variable "Env" {
  type = string
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat","demo"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "github_token" {
  type = string
}
variable "tenant_id" {
  type = string
}

variable "subscription_id" {
  type = string
}
variable "subscription_name" {
  type = string
}
variable "org_service_url" {
  type = string
  default = "xxxxxxxxxxxx"
}

variable "sonar_token" {
  type = string
}

variable "acr_name" {
  type = string
}