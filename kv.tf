resource "azurerm_key_vault" "this" {
  name                        = "${local.base_name}-kv"
  location                    = azurerm_resource_group.this["aks"].location
  resource_group_name         = azurerm_resource_group.this["aks"].name
  enabled_for_disk_encryption = true
  tenant_id = "77faded0-f99b-4711-bcc8-4a363cb0ae6d"
  #soft_delete_retention_days  = 0
  purge_protection_enabled    = false
  enable_rbac_authorization = true

  sku_name = "standard"


}

resource "azurerm_role_assignment" "kv" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Secrets Officer"
  principal_id         = azuread_group.this.object_id
}

resource "azurerm_key_vault_secret" "aks-kubeconfig" {
  name         = "${local.base_name}-kube-config"
  value        = azurerm_kubernetes_cluster.this.kube_config_raw
  key_vault_id = azurerm_key_vault.this.id
}