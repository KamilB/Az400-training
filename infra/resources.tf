resource "azurerm_resource_group" "az400terraform" {
  name     = "az400terraform"
  location = "West Europe"
}

resource "azurerm_app_service_plan" "az400serviceplan" {
  name                = "az400serviceplan"
  location            = azurerm_resource_group.az400terraform.location
  resource_group_name = azurerm_resource_group.az400terraform.name

  sku {
    tier = "Standard"
    size = "S1"
  }
}

resource "azurerm_app_service" "az400app_service" {
  name                = "WebApp-az400"
  location            = azurerm_resource_group.az400terraform.location
  resource_group_name = azurerm_resource_group.az400terraform.name
  app_service_plan_id = azurerm_app_service_plan.az400serviceplan.id

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY" = azurerm_application_insights.az400insigts.instrumentation_key
  }
}

resource "azurerm_application_insights" "az400insigts" {
  name                = "tf-test-appinsights"
  location            = azurerm_resource_group.az400terraform.location
  resource_group_name = azurerm_resource_group.az400terraform.name
  application_type    = "web"
}