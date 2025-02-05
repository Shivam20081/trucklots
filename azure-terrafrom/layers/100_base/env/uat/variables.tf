# 100_base

variable "Env" {
  description = "The name of the environment, e.g. prod, qa, dev"
  type        = string
  default     = "uat"
}

variable "subscription_id" {
  description = "The xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx subcription id"
  type        = string
  default     = "TODO"
}
