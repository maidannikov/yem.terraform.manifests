output "acr_username" {
  value       = azurerm_container_registry.acr.admin_username
  description = "The username for the Azure Container Registry."
}

output "acr_password" {
  value       = azurerm_container_registry.acr.admin_password
  description = "The password for the Azure Container Registry."
  sensitive   = true
}