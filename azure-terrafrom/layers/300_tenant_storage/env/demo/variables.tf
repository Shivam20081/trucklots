# 300_tenant_storage

variable "Env" {
  description = "The name of the environment, e.g. prod, qa, dev"
  type        = string
  default     = "demo"
}

variable "rg_name" {
  type = string
  default = "GREENSIGHT-DEMO-STORAGE"
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

variable "dynamic_rules" {
  type    = list(object({
    container_name          = string
    rule_enable             = bool
    time_to_move_to_archive = number
    time_to_move_to_cool    = number
    path                    = string
  }))
  default = [
######################### Policy for Logs Container ###########################
    {
    container_name          = "logs"
    rule_enable             = true
    time_to_move_to_archive = 90
    time_to_move_to_cool    = 14
    path                    = "*" 
    }
  ]
}