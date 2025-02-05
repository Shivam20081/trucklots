# 200_datalake

variable "Env" {
  type = string
  default = "dev"
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "rg_name" {
  type = string
  default = "GREENSIGHT-DEV-MISC"
}

variable "rg_location" {
  type = string
  default = "East US"
}

variable "subscription_id" {
  description = "The xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx subcription id"
  type        = string
  default     = "TODO"
}