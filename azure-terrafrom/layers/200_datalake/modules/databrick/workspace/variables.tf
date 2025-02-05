variable "Env" {
  type = string
  description = "Enter the specified Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

locals{
  EnvAcct = var.Env == "prod" ? "prod" : "nonp"
}

variable "rg_location" {
  type = string
}

variable "counts" {
  type = string
}

variable "rg_name1" {
  type = string
}

variable "rg_name2" {
  type = string
}

variable "databrick_private_subnet_name" {
  type = string
}

variable "databrick_public_subnet_name" {
  type = string
}

variable "virtual_network_id" {
  type = string
}

variable "public_subnet_network_security_group" {
  type = string
}

variable "private_subnet_network_security_group" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "storage_sku" {
  type = string
}