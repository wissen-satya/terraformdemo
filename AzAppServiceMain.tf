/*
* Provider block defines which provider they require
*/

terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.71.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  # More information on the authentication methods supported by
  # the AzureRM Provider can be found here:
  # https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs

  subscription_id = "65911ece-b772-4e16-ab25-fc95982846dc"
   client_id       = "37f075a8-9437-4317-84e7-8106b3c2c6a3"
   client_secret   = "ui8lG0EanXUt.M3ZM-T8P8krICoaEk.RS6"
   tenant_id       = "8a38d5c9-ff2f-479e-8637-d73f6241a4f0"
}

/*
* Resource Group
*/
resource "azurerm_resource_group" "RG" {
  name     = var.RsourceGroupName
  location = var.location
}

/*
* App Service Plan
*/
resource "azurerm_app_service_plan" "AppSerPlan" {
  name                = var.AppServicePlanName
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  kind                = "Windows"

  sku {
    tier = "Standard"
    size = "S1"
  }
}

/*
* App Service
*/
resource "azurerm_app_service" "AppService" {
  name                = var.AppServiceName
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  app_service_plan_id = azurerm_app_service_plan.AppSerPlan.id

  site_config {
    websockets_enabled = true
  }

  app_settings = {
    "APPINSIGHTS_INSTRUMENTATIONKEY"      = "${azurerm_application_insights.AppInsight.instrumentation_key}"
    "APPINSIGHTS_PORTALINFO"              = "ASP.NET"
    "APPINSIGHTS_PROFILERFEATURE_VERSION" = "1.0.0"
    "WEBSITE_HTTPLOGGING_RETENTION_DAYS"  = "35"
  }
}

/*
* Application Insights
*/
resource "azurerm_application_insights" "AppInsight" {
  name                = var.ApplicationInsightsName
  location            = azurerm_resource_group.RG.location
  resource_group_name = azurerm_resource_group.RG.name
  application_type    = "web"
}