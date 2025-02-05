# 200_datalake

variable "Env" {
  description = "The name of the environment, e.g. prod, qa, dev"
  type        = string
  default     = "prod"
}

variable "subscription_id" {
  description = "The xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx subcription id"
  type        = string
  default     = "14849230-3e34-4171-955d-0832056008b0"
}

variable "org_service_url" {
  type = string
  default = "https://dev.azure.com/greensight/"
}