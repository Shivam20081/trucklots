variable "Env" {
  type = string
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat","demo", "research"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "counts" {
  type = string
}

variable "rg_name" {
  type = string
}

variable "sku_name" {
  type = string
}
variable "rg_location" {
  type = string
  
}