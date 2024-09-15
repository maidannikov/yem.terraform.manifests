variable "client_id" {
  description = "Azure Service Principal Client ID"
  type        = string
}

variable "client_secret" {
  description = "Azure Service Principal Client Secret"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "tfc-cloud-resources"
}

variable "location" {
  description = "The Azure region to deploy resources into"
  type        = string
  default     = "uksouth"
}

variable "acr_name" {
  description = "The name of the Azure Container Registry"
  type        = string
  default = "yemacr"
}

variable "acr_sku" {
  description = "The SKU of the Azure Container Registry (e.g., Basic, Standard, Premium)"
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Enable admin user for ACR"
  type        = bool
  default     = true
}

variable "app_service_plan_name" {
  description = "The name of the App Service Plan"
  type        = string
  default     = "wfmonitor-sp"
}

variable "web_app_name" {
  description = "The name of the Web App"
  type        = string
  default     = "wfmonitor"
}

variable "tags" {
  description = "A map of tags to assign to the resource"
  type        = map(string)
  default     = {
    environment = "dev"
    createdby = "terraform"
    owner = "yem"
  }
}