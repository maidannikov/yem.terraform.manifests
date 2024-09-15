resource "azurerm_resource_group" "acr-rg" {
  name     = var.resource_group_name
  location = var.location
  tags = var.tags
}

resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = azurerm_resource_group.acr-rg.name
  location            = azurerm_resource_group.acr-rg.location
  sku                 = var.acr_sku
  admin_enabled       = var.admin_enabled
  tags = var.tags
}

resource "azurerm_service_plan" "webapp-sp" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.acr-rg.location
  resource_group_name = azurerm_resource_group.acr-rg.name
  os_type    = "Linux"
  sku_name = "B1"
  tags = var.tags
}

resource "azurerm_linux_web_app" "webapp" {
  name                = "wfmonitor"
  location            = azurerm_resource_group.acr-rg.location
  resource_group_name = azurerm_resource_group.acr-rg.name
  service_plan_id     = azurerm_service_plan.webapp-sp.id

  site_config {
    application_stack {
      python_version = "3.10"
    }
  }
}
