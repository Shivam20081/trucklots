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

variable "origin_group_id" {
  type = string
}

variable "host_name" {
  type = string
}

variable "host_id" {
  type = string
  default = null
}

variable "enable_private_link" {
  type = bool
}

