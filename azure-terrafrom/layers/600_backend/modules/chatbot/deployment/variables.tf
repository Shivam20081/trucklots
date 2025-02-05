variable "Env" {
  type = string
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat","demo"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "open_id" {
  type = string
}

variable "counts" {
  type = string
}

variable "model_name" {
  type = string
}

variable "model_version" {
  type = string
}

variable "token_capacity" {
  type = number
}

variable "deployment_type" {
  type = string
}