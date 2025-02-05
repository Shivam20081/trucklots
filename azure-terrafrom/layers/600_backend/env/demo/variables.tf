# 600_backend

variable "Env" {
  description = "The name of the environment, e.g. prod, demo, dev"
  type        = string
  default     = "demo"
}

variable "rg_name" {
  type        = string
  default     = "GREENSIGHT-DEMO-BACKEND"
}

variable "rg_location" {
  type = string
  default = "East US"
}

variable "subscription_id" {
  description = "The xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx subcription id"
  type        = string
  default     = "131c63be-0236-4b92-bdbb-79dbc6b80f5e"
}