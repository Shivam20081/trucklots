variable "rg_name" {
  type = string
}

variable "Env" {
  type = string
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "demo", "prod","qa","uat"], var.Env)
    error_message = "Please enter a valid value from dev demo qa uat prod"
  }
}

locals{
  EnvAcct = var.Env == "prod" ? "prod" : "nonp"
}

variable "counts" {
  type = string
}

variable "container_cpu" {
  type = string
}

variable "container_memory" {
  type = string
}

variable "app_environment_id" {
  type    = string
}

variable "image" {
  type = string
}

variable "acr_password" {
  type = string
}

variable "acr_server" {
  type = string
}

variable "acr_username" {
  type = string
}

variable "environment_variable" {
  type = list(object({
    name = string
    value = string
  }))
}

variable "min_replicas" {
  type = number
}

variable "max_replicas" {
  type = number
}

variable "container_port" {
  type = number
}