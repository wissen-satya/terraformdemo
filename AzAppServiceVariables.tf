## App Service Plan variables
variable "RsourceGroupName" {
  description = "The name of the resource group"
}

variable "location" {
  description = "The Azure region in which all resources should be created"
}

# App Service
variable "AppServicePlanName" {
  description = "The name of the app service plan for the backend"
}

variable "AppServiceName" {
  description = "The name of the app service for the backend"
}

# Application Insights
variable "ApplicationInsightsName" {
  description = "The name of the application insights resource"
}