variable "Env" {
  type = string
  description = "Enter the specified Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "node_type" {
  type = string
}

variable "spark_version" {
  type = string
}

variable "key_vault_id" {
  type = string
}