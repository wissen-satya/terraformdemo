
terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "=2.71.0"
    }
  }
}


resource "azurerm_app_service_plan" "appserviceplan" {
  name                = "appserviceplan"
  location            = "East Us"
  resource_group_name = "POC_DevOps_RG"

  sku {
    tier = "Premiumv2"
    size = "P1v2"
  }
}

resource "azurerm_app_service" "SPJTestWebApp" {
  name = "SPJTestWebApp"
  location = "East Us"
  resource_group_name = "POC_DevOps_RG"
  app_service_plan_id = azurerm_app_service_plan.appserviceplan.id
  
}

# resource "azurerm_app_service" "SPJWebApp" {
#   name                = "SPJWebApp"
#   location            = azurerm_resource_group.POC_DevOps_RG.location
#   resource_group_name = azurerm_resource_group.POC_DevOps_RG.name
#   app_service_plan_id = azurerm_app_service_plan.appserviceplan.id
# }



