terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.5.0"
    }
  }
}

provider "azurerm" {
    resource_provider_registrations = "none"
    subscription_id = "db0c1653-dade-4dcb-bd7a-9954cb17956e"
   features {
   }
}

provider "random" {

}


