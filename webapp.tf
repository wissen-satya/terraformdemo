# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
#Reference https://docs.microsoft.com/en-us/azure/app-service/scripts/terraform-secure-backend-frontend  
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



