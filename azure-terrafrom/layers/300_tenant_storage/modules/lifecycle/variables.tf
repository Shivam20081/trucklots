
variable "storage_account_id" {
  type = string
}

variable "dynamic_rules" {
  type    = list(object({
    container_name          = string
    rule_enable             = bool
    time_to_move_to_archive = number
    time_to_move_to_cool    = number
    path                    = string
  }))
}