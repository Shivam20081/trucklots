# 500_database

variable "Env" {
  description = "The name of the environment, e.g. prod, qa, dev"
  type        = string
  default     = "prod"
}

variable "rg_name" {
  type        = string
  default     = "GREENSIGHT-PROD-DATABASE"
}

variable "rg_location" {
  type = string
  default = "East US"
}

variable "subscription_id" {
  description = "The xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx subcription id"
  type        = string
  default     = "14849230-3e34-4171-955d-0832056008b0"
}

variable "subresource_name" {
  type = list(string)
  default = [ "sqlServer" ]
}
