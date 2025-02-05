# 300_tenant_storage

variable "Env" {
  description = "The name of the environment, e.g. prod, qa, dev"
  type        = string
  default     = "prod"
}

variable "rg_name" {
  type = string
  default = "GREENSIGHT-PROD-STORAGE"
}

variable "rg_location" {
  type = string
  default = "East US"
}

variable "subresource_name" {
  type = list(string)
  default = [ "Blob" ]
}

variable "subscription_id" {
  description = "The xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx subcription id"
  type        = string
  default     = "14849230-3e34-4171-955d-0832056008b0"
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
    },
######################### Policy for Pilot Container ###########################
    {
    container_name          = "pilot-container"
    rule_enable             = true
    time_to_move_to_archive = 90
    time_to_move_to_cool    = 14
    path                    = "logs" 
    },
    {
    container_name          = "pilot-container"
    rule_enable             = true
    time_to_move_to_archive = 90
    time_to_move_to_cool    = 14
    path                    = "archive" 
    },
######################### Policy for Schneider Container ###########################

    {
    container_name          = "schneider-container"
    rule_enable             = true
    time_to_move_to_archive = 90
    time_to_move_to_cool    = 14
    path                    = "logs" 
    },
    {
    container_name          = "schneider-container"
    rule_enable             = true
    time_to_move_to_archive = 90
    time_to_move_to_cool    = 14
    path                    = "archive" 
    },
######################### Policy for GMI Container ###########################

    {
    container_name          = "gmi-container"
    rule_enable             = true
    time_to_move_to_archive = 90
    time_to_move_to_cool    = 14
    path                    = "logs" 
    },
    {
    container_name          = "gmi-container"
    rule_enable             = true
    time_to_move_to_archive = 90
    time_to_move_to_cool    = 14
    path                    = "archive" 
    },
######################### Policy for GMI Container ###########################

    {
    container_name          = "lowes-container"
    rule_enable             = true
    time_to_move_to_archive = 90
    time_to_move_to_cool    = 14
    path                    = "logs" 
    },
    {
    container_name          = "lowes-container"
    rule_enable             = true
    time_to_move_to_archive = 90
    time_to_move_to_cool    = 14
    path                    = "archive" 
    },
  ]
}