resource "azurerm_ssh_public_key" "this" {


  name = "${local.base_name}-pubkey"

  location            = azurerm_resource_group.this["aks"].location
  resource_group_name = azurerm_resource_group.this["aks"].name
  public_key          = file("${path.module}/ssh-key/aks-ssh-key.pub")
  lifecycle {
    ignore_changes = [
      public_key,
    ]
  }


}

resource "azurerm_kubernetes_cluster" "this" {
  name                = "${local.base_name}-aks"
  location            = azurerm_resource_group.this["aks"].location
  resource_group_name = azurerm_resource_group.this["aks"].name
  dns_prefix          = "frstdemoaks"
  node_resource_group = "${local.base_name}-aks-nodepool"
  # Authentication settings
  role_based_access_control_enabled = true
  oidc_issuer_enabled               = true
  workload_identity_enabled         = true
  azure_policy_enabled         = true

  default_node_pool {
    name = "default"
    #node_count = 1
    vm_size              = "Standard_D2_v2"
    auto_scaling_enabled = true
    min_count            = 1
    max_count            = 2
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.tag

  linux_profile {
    admin_username = "localadmin"

    ssh_key {
      key_data = azurerm_ssh_public_key.this.public_key
    }
  }
  network_profile {
    network_plugin    = "kubenet"
    load_balancer_sku = "standard"
  }
  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }
  azure_active_directory_role_based_access_control {
      azure_rbac_enabled = true
      admin_group_object_ids = [azuread_group.this.object_id]


  }
}

output "client_certificate" {
  value     = azurerm_kubernetes_cluster.this.kube_config[0].client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.this.kube_config_raw

  sensitive = true
}