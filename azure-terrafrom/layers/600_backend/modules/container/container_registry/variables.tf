variable "rg_name" {
  type = string
}

variable "Env" {
  type = string
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "demo","prod","qa","uat"], var.Env)
    error_message = "Please enter a valid value from dev demo qa uat prod"
  }
}

locals{
  EnvAcct = var.Env == "prod" ? "prod" : "nonp"
}

variable "counts" {
  type = string
}

variable "rg_location" {
  type = string
}

variable "sku_name" {
  type = string
}