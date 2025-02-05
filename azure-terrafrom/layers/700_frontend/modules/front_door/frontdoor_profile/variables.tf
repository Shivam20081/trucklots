variable "Env" {
  type = string
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat","demo"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

locals{
  EnvAcct = var.Env == "prod" ? "prod" : "nonp"
}

variable "counts" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "timeout" {
  type = number
}

variable "sku_name" {
  type = string
}

variable "certificate_id" {
  type = string
}

variable "identity_id" {
  type = string
}