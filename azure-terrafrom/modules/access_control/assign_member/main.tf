resource "azuread_group_member" "add_member" {
  group_object_id  = data.azuread_group.group.object_id
  member_object_id = data.azuread_user.member.id
}