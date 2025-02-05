variable "Env" {
  type = string
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat","demo"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "rg_name" {
  type = string
}
locals{
  EnvAcct = var.Env == "prod" ? "prod" : "nonp"
}

variable "cdn_name" {
  type = string
}

variable "counts" {
  type = string
}

variable "host" {
  type = string
}

variable "frontend_url" {
  type = string
  default = null
}

variable "content_type" {
  type = string
  validation {
    condition = contains(["json", "report"], var.content_type)
    error_message = "Please enter a valid value from content type"
  }
}

variable "origin_path" {
  type = string
  default = null
}

locals {
  cors_url    = var.content_type == "json" ? var.frontend_url : null
}
