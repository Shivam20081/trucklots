

# variables.tf

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "storage_admin_actions" {
  description = "Actions for Storage Admin role"
  type        = list(string)
  default     = ["Microsoft.Storage/storageAccounts/read", "Microsoft.Storage/storageAccounts/write"]
}

variable "network_admin_actions" {
  description = "Actions for Network Admin role"
  type        = list(string)
  default     = [
    "Microsoft.Network/networkInterfaces/read",
    "Microsoft.Network/networkInterfaces/write",
    "Microsoft.Network/virtualNetworks/read",
    "Microsoft.Network/virtualNetworks/write",
    "Microsoft.Network/publicIPAddresses/read",
    "Microsoft.Network/publicIPAddresses/write",
    "Microsoft.Network/networkSecurityGroups/read",
    "Microsoft.Network/networkSecurityGroups/write",
  ]
}

variable "database_admin_actions" {
  description = "Actions for Database Admin role"
  type        = list(string)
  default     = [
    "Microsoft.Sql/servers/databases/read",
    "Microsoft.Sql/servers/databases/write",
    "Microsoft.Sql/servers/firewallRules/read",
    "Microsoft.Sql/servers/firewallRules/write",
    "Microsoft.Sql/servers/elasticPools/read",
    "Microsoft.Sql/servers/elasticPools/write",
  ]
}

variable "security_operator_actions" {
  description = "Actions for Security Operator role"
  type        = list(string)
  default     = [
    "Microsoft.Security/securityContacts/read",
    "Microsoft.Security/advancedThreatProtectionSettings/read",
    "Microsoft.Security/secureScores/read",
    "Microsoft.Insights/components/read",
    "Microsoft.Insights/components/write",
  ]

}

variable "support_staff_actions" {
  description = "Actions for Support Staff role"
  type        = list(string)
  default     = ["*"]
}