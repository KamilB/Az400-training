data "azurerm_container_registry" "spark_registry" {
  name                = "az400testApril"
  resource_group_name = "az400"
}
