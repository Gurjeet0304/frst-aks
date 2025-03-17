
locals {
  subnets = {
    node_subnet = cidrsubnet(var.address_space, 1, 0)
    pod_subnet  = cidrsubnet(var.address_space, 1, 1)
  }
}

resource "azurerm_virtual_network" "this" {
  name                = "${local.base_name}-aks-vnet"
  location            = azurerm_resource_group.this["net"].location
  resource_group_name = azurerm_resource_group.this["net"].name
  address_space       = ["10.0.0.0/22"]
  dynamic "subnet" {
    for_each = local.subnets
    content {
      name             = subnet.key
      address_prefixes = [subnet.value]
    }
  }

  tags = local.tag
}