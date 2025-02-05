# 200_datalake

variable "Env" {
  description = "The name of the environment, e.g. prod, qa, dev"
  type        = string
  default     = "qa"
}

variable "rg_location" {
  type = string
  default = "East US"
}

variable "rg_name" {
  type = string
  default = "GREENSIGHT-QA-MISC"
}

variable "rg_name_secondary" {
  type = string
  default = "GREENSIGHT-QA-DATABRICK"
}
variable "subscription_id" {
  description = "The xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx subcription id"
  type        = string
  default     = "0f4a2d5b-f5ad-4470-9319-cbb4e68356a3"
}