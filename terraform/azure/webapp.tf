resource "azurerm_service_plan" "webapp-sp" {
  name                = var.app_service_plan_name
  location            = azurerm_resource_group.acr-rg.location
  resource_group_name = azurerm_resource_group.acr-rg.name
  os_type    = "Linux"
  sku_name = "B1"
  tags = var.tags
}

resource "azurerm_linux_web_app" "webapp" {
  name                = var.web_app_name
  location            = azurerm_resource_group.acr-rg.location
  resource_group_name = azurerm_resource_group.acr-rg.name
  service_plan_id     = azurerm_service_plan.webapp-sp.id

  site_config {
    application_stack {
      docker_image {
        image_name       = "${azurerm_container_registry.acr.login_server}/${var.web_app_name}:latest"
        registry_url     = azurerm_container_registry.acr.login_server
        registry_username = azurerm_container_registry.acr.admin_username
        registry_password = azurerm_container_registry.acr.admin_password
      }
    }
  }

  auth_settings {
    enabled = true
    active_directory {
      client_id     = var.client_id
      client_secret = var.client_secret
      allowed_audiences = [
        "https://${var.web_app_name}.azurewebsites.net"
      ]
    }
  }
}

