terraform {
  required_providers {
    azurerm = {
      source = "hashicorp/azurerm"
      version = "4.5.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "crgar-migrate-tf-rg"
    storage_account_name = "crgarmigratetfstate"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
    resource_provider_registrations = "none"
    subscription_id = "96c2852b-cf88-4a55-9ceb-d632d25b83a4"
   features {
   }
}

provider "random" {

}


