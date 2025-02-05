# main.tf

resource "azurerm_role_definition" "storage_admin" {
  name        = "Storage Admin"
  description = "Custom role for Storage Admins with read and write permissions"
  scope       = "/subscriptions/${var.subscription_id}"

  permissions {
    actions = var.storage_admin_actions
    not_actions = []
  }

  assignable_scopes = ["/subscriptions/${var.subscription_id}"]
}

resource "azurerm_role_definition" "network_admin" {
  name        = "Network Admin"
  description = "Custom role for Network Admins with read and write permissions"
  scope       = "/subscriptions/${var.subscription_id}"

  permissions {
    actions = var.network_admin_actions
    not_actions = []
  }
}

resource "azurerm_role_definition" "database_admin" {
  name        = "Database Admin"
  description = "Custom role for Database Admins with read and write permissions"
  scope       = "/subscriptions/${var.subscription_id}"

  permissions {
    actions = var.database_admin_actions
    not_actions = []
  }
}

resource "azurerm_role_definition" "security_operator" {
  name        = "Security Operator"
  description = "Custom role for Security Operators with read-only access"
  scope       = "/subscriptions/${var.subscription_id}"

  permissions {
    actions = var.security_operator_actions
    not_actions = []
  }
}

resource "azurerm_role_definition" "support_staff" {
  name        = "Support Staff"
  description = "Custom role for Support Staff with read-only access"
  scope       = "/subscriptions/${var.subscription_id}"

  permissions {
    actions = var.support_staff_actions
    not_actions = []
  }
}