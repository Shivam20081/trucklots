variable "Env" {
  type = string
  default = "dev"
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

locals{
  EnvAcct = var.Env == "prod" ? "prod" : "nonp"
}

variable "rg_name" {
  type = string
}

variable "rg_location" {
  type = string
}

variable "counts" {
  type = string
}

variable "workspace_url" {
  type = string
}

variable "cluster_id" {
  type = string
}

variable "access_token" {
  type = string
}
