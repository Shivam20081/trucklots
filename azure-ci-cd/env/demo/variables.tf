# 200_datalake

variable "Env" {
  description = "The name of the environment, e.g. prod, qa, dev"
  type        = string
  default     = "demo"
}

variable "subscription_id" {
  description = "The xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx subcription id"
  type        = string
  default     = "131c63be-0236-4b92-bdbb-79dbc6b80f5e"
}

variable "org_service_url" {
  type = string
  default = "https://dev.azure.com/greensight/"
}