variable "Env" {
  type = string
  default = "qa"
}

variable "subscription_id" {
  description = "The xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx subcription id"
  type        = string
  default     = "0f4a2d5b-f5ad-4470-9319-cbb4e68356a3"
}

variable "org_service_url" {
  type = string
  default = "https://dev.azure.com/greensight/"
}
