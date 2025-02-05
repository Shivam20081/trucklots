variable "v_net_name" {
    type = string  
}

variable "subnet_cidr" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "subnet_name" {
  type = string
}

variable "Env" {
  type = string
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat", "demo"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "delegation" {
  type = string
}