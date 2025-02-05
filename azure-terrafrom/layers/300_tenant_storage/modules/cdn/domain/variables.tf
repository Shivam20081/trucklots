
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

variable "custom_domain" {
  type = string
}

variable "endpoint_id" {
  type = string
}