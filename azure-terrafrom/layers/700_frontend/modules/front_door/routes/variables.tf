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

variable "endpoint_id" {
  type = string
}

variable "origin_group_id" {
  type = string
}

variable "rule_set_ids" {
  type = list(string)
}

variable "origin_ids" {
  type = list(string)
}

variable "custom_domain" {
  type = bool
  default = false
}

variable "custom_domain_id" {
  type = string
  default = null
}