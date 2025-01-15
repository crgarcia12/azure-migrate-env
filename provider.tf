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
    subscription_id = ""
   features {
   }
}

provider "random" {

}


