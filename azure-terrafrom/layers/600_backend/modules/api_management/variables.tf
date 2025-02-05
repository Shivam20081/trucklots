variable "Env" {
  type = string
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev","prod","qa","demo","research"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
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

locals{
  EnvAcct = var.Env == "prod" ? "prod" : "nonp"
}

variable "publisher_email" {
  type = string
}

variable "publisher_name" {
  type = string
}
variable "sku_name" {
  type = string
}

variable "application_insights_key" {
  type = string
}

variable "application_insights_id" {
  type = string
}