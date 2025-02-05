variable "subnet_id" {
  type = string
}

variable "public_ip" {
  type = string
}

variable "rg_location" {
  type = string
}

variable "rg_name" {
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

variable "targaet_list" {
  type = list(string)
}

variable "counts" {
  type = string
}

locals{
  EnvAcct = var.Env == "prod" ? "prod" : "nonp"
  gatway_name = "GS-apg-appgateway-${var.Env}-eastus-${var.counts}"
}

variable "certificate_id" {
  type = string
}

variable "identity_id" {
  type =  string
}

locals {
  backend_address_pool_name      = "${local.gatway_name}-beap"
  frontend_port_name1            = "${local.gatway_name}-feport1"
  frontend_port_name2            = "${local.gatway_name}-feport2"
  frontend_ip_configuration_name = "${local.gatway_name}-feip"
  http_setting_name              = "${local.gatway_name}-be-htst"
  listener_name1                 = "${local.gatway_name}-httplstn1"
  listener_name2                 = "${local.gatway_name}-httplstn2"
  request_routing_rule_name1     = "${local.gatway_name}-rqrt1"
  request_routing_rule_name2     = "${local.gatway_name}-rqrt2"
  redirect_configuration_name    = "${local.gatway_name}-rdrcfg"
  ssl_certificate_name           = "${local.gatway_name}-ssl"
}

variable "firewall_policy_id" {
  type = string
}

variable "sku" {
  type = string
}

locals {
  firewall_policy_id = var.sku == "WAF_v2" ? var.firewall_policy_id : null
}