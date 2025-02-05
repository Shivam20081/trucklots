# 700_frontend

variable "Env" {
  type = string
  default = "demo"
}

variable "rg_location" {
  type = string
  default = "East US"
}

variable "rg_name" {
  type = string
  default = "GREENSIGHT-DEMO-FRONTEND"
}

variable "subresource_name" {
  type = list(string)
  default = [ "staticSites" ]
}

variable "subscription_id" {
  description = "The xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx subcription id"
  type        = string
  default     = "131c63be-0236-4b92-bdbb-79dbc6b80f5e"
}