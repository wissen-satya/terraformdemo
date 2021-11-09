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
