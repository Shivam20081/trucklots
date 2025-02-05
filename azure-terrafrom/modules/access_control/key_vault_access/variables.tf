variable "key_permissions" {
  type = list(string)
}

variable "key_vault_id" {
  type = string
}

variable "storage_permissions" {
  type = list(string)
}

variable "secret_permissions" {
  type = list(string)
}

# ["Get","Create","Delete","List","Restore","Recover","UnwrapKey","WrapKey","Purge","Encrypt","Decrypt","Sign","Verify","GetRotationPolicy","SetRotationPolicy"]
