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

resource "azurerm_app_service_plan" "webappplan" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.acr-rg.location
  resource_group_name = azurerm_resource_group.acr-rg.name
  kind                = "Linux"
  sku {
    tier = "Basic"
    size = "B1"
  }
  reserved = true
}

resource "azurerm_linux_web_app" "example" {
  name                = var.web_app_name
  location            = azurerm_resource_group.acr-rg.location
  resource_group_name = azurerm_resource_group.acr-rg.name
  service_plan_id     = azurerm_app_service_plan.webappplan.id

  site_config {
    linux_fx_version = "PYTHON|3.12"
  }
  tags = var.tags
}