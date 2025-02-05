variable "port" {
  type = number
}

variable "rule_name" {
  type = string
}

variable "priority" {
  type = number
}

variable "rg_name" {
  type = string
}

variable "sg_name" {
  type = string
}

variable "direction" {
  type = string
  validation {
    condition = contains(["Inbound", "Outbound"], var.direction)
    error_message = "Please enter a valid value from Outbound or Inbound"
  }
}