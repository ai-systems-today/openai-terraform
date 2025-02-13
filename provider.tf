terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.00"
    }
  }
  backend "azurerm" {
    resource_group_name  = "rg-state"
    storage_account_name = "satfstartext"
    container_name       = "catfstaterxt"
    key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}