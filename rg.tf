resource "azurerm_resource_group" "this" {
  for_each = toset(["net", "node", "aks", "acr"])
  name     = "${local.base_name}-${each.key}-rg"
  location = local.deployment_region.location
}


