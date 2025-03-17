resource "azurerm_kubernetes_cluster_node_pool" "this" {
  name                  = "internal"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.this.id
  vm_size               = "Standard_DS2_v2"
  auto_scaling_enabled  = true
  min_count             = 1
  max_count             = 2

  tags = {
    Environment = "Production"
  }
}



