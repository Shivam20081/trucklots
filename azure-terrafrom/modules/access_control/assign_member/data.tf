data "azuread_user" "member" {
  user_principal_name = var.member
}

data "azuread_group" "group" {
  display_name     = var.group_name
  security_enabled = true
}