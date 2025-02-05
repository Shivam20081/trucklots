variable "Env" {
  type = string
  description = "Enter the specifyed Environment"
  validation {
    condition = contains(["dev", "prod","qa","uat","demo", "research"], var.Env)
    error_message = "Please enter a valid value from dev qa uat prod"
  }
}

variable "frontend_url" {
  type = list(string)
}

variable "counts" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "storage_access_key" {
  type = string
}

variable "rg_name" {
  type = string
}

locals{
  EnvAcct = var.Env == "prod" ? "prod" : "nonp"
}

variable "app_env_variables" {
  type    = map(string) 
}

variable "application_insights_key" {
  type = string
}

variable "application_insights_connection_string" {
 type = string 
}

variable "allowed_ip" {
  type    = string
  default = null
}

variable "service_plan_id" {
  type = string
}

variable "apply_ip_restriction" {
  type        = bool
  default     = false
}
variable "rg_location" {
  type = string
  
}
variable "appsuite" {
  type = string
}
variable "application_stack" {
  type    = map(string)
}

variable "identity_id" {
  type = string
}