resource "azurerm_container_registry" "this" {
  name                = "frstdemoacr"
  resource_group_name = azurerm_resource_group.this["acr"].name
  location            = azurerm_resource_group.this["acr"].location
  sku                 = "Premium"
}