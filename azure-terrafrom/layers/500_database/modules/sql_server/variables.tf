variable "counts" {
  type = string
}

locals{
  EnvAcct = var.Env == "prod" ? "prod" : "nonprod"
  auto_pause = var.ltrp ? -1 : var.auto_pause_min
}

variable "auto_pause_min" {
  type = number
  default = 60
}

variable "Env" {
  type = string
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat","demo"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "rg_location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "key_vault_id" {
  type = string
}

variable "sql_db_sku" {
  type = string
}

variable "storage" {
  type = number
}

variable "ltrp" {
  type = bool
  description = "Long Term Retention Ploicy"
}