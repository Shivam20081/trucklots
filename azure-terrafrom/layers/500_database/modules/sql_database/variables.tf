variable "server_id" {
  type = string
}

variable "Env" {
  type = string
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat","demo"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "tenant_name" {
  type = string
}


variable "auto_pause_min" {
  type = number
  default = 60
}

locals{
  EnvAcct = var.Env == "prod" ? "prod" : "nonp"
  auto_pause = var.ltrp ? -1 : var.auto_pause_min
}

variable "sql_db_sku" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "server_name" {
  type = string
}

variable "server_username" {
  type = string
}

variable "server_password" {
  type = string
}

variable "key_vault_id" {
  type = string
}

variable "storage" {
  type = number
}

variable "ltrp" {
  type = bool
  description = "Long Term Retention Ploicy"
}