variable "rg_location" {
  type = string
  default = "East US"
}

variable "rg_name" {
  type = string
}

variable "cidr_v_net" {
  type = string
}

variable "counts" {
  type = string
}

locals{
  EnvAcct = var.Env == "prod" ? "prod" : "nonp"
}

variable "Env" {
  type = string
  default = "dev"
  description = "Enter the specified Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat","demo"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}
