# tfstate module

variable "Env" {
  description = "The name of the environment, e.g. prod, qa, dev"
  type        = string
  default     = "dev"
}

variable "region" {
  description = "The Azure region the state should reside in"
  type        = string
  default     = "East US"
}

variable "tags" {
  description = "Tags to place on the created resources"
  type        = map(any)
}