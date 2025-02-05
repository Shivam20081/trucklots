locals{
  EnvAcct = var.Env == "prod" ? "prod" : "nonprod"
}

variable "Env" {
  type = string
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat","demo"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "rg_name" {
  type = string
  default = "GREENSIGHT-DEV-STORAGE"
}