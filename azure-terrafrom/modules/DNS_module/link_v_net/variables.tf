variable "vnet_id" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "DNS_name" {
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

variable "auto_registration" {
  type = bool
}
