variable "Env" {
  type = string
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat","demo"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "counts" {
  type = string
}

variable "domain" {
  type = string
}

variable "frontdoor_id" {
  type = string 
}

variable "secret_id" {
  type = string
}

variable "route_id" {
  type = string
}