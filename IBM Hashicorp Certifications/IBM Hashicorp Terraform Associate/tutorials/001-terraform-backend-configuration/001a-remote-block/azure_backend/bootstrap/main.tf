terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 3.0"
    }
  }
  /*
  backend "azurerm" {
    storage_account_name = "satfstatedevops20240329"
    container_name       = "tfstate"
    key                  = "bootstrp.terraform.tfstate"
    access_key = "<REPLACE_ME>"
  }*/
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "terraform_state" {
  name = "rg-terraform-state"
  location = "East Us"
   tags = {
    terraform = "true"
  }
}

resource "azurerm_storage_account" "terraform_state" {
  name                     = "satfstatedevops20240329"
  resource_group_name      = azurerm_resource_group.terraform_state.name
  location                 = azurerm_resource_group.terraform_state.location
  account_tier             = "Standard"
  account_replication_type = "GRS"

  tags = {
    terraform = "true"
  }
}

resource "azurerm_storage_container" "terraform_state" {
  name = "tfstate"
  storage_account_name = azurerm_storage_account.terraform_state.name
  container_access_type = "private"
}