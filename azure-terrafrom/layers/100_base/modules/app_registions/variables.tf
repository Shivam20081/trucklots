variable "Env" {
  type = string
  default = "dev"
  description = "Enter the specified Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat","demo"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "object_id" {
  type = string
}

variable "counts" {
  type = string
}

variable "key_vault_id" {
  type = string
}