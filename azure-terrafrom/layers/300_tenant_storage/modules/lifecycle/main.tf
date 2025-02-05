resource "azurerm_storage_management_policy" "lifecycle" {
  storage_account_id = var.storage_account_id

#  UPDATE VARIABLE (dynamic_rules) FOR ANY CHANGES IN POLICY OR NEW POLICY 

  dynamic "rule" {
    for_each = var.dynamic_rules
    content {
      name    = "rule-for-${rule.value.container_name}-${rule.value.path}"
      enabled = rule.value.rule_enable
      filters {
        prefix_match = ["${rule.value.container_name}/${rule.value.path}"]
        blob_types   = ["blockBlob"]
      }
      actions {
        base_blob {
          tier_to_cool_after_days_since_creation_greater_than  = rule.value.time_to_move_to_cool
          tier_to_archive_after_days_since_creation_greater_than = rule.value.time_to_move_to_archive
        }
      }
    }
  }
}