variable "rg_location" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "Env" {
  type = string
}

locals{
  EnvAcct = var.Env == "prod" ? "prod" : "nonp"
}
