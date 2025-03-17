data "azuread_client_config" "current" {}

resource "azuread_group" "this" {
  display_name     = "Frst AKS Administrator"
  owners           = [data.azuread_client_config.current.object_id]
  security_enabled = true
  members = [
    "11cbf664-6cde-44a4-bb9d-e40bde7f9dcf"  #self study account
  ]
}