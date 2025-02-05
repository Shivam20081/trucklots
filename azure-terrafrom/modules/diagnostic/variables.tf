variable "counts" {
  type = string
}

variable "target_id" {
  type = string
}

variable "storage_account_id" {
  type = string
}


variable "log_analytics_id" {
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
