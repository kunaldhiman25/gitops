terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=4.1.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}

  tenant_id       = "add67cd2-c8b2-416c-b171-b61b22be92f4"
  subscription_id = "b6bc018a-adec-45c6-bf16-bd8a24b927ac"

}