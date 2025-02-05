variable "Env" {
  type = string
  default = "dev"
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["prod"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

locals{
  EnvAcct = var.Env == "prod" ? "prod" : "nonp"
}

variable "profile_id" {
  type = string
}

variable "counts" {
  type = string
}

variable "custom_domain_id" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "sku_name" {
  type = string
}