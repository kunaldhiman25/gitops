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

  client_id       = "f9ff2e1f-64a9-43f2-8b15-04d549484fa3"
  client_secret   = "0yl8Q~v_JmBXBr.K10VEKnF6yp3xYnWmzZln8ckL"
  tenant_id       = "add67cd2-c8b2-416c-b171-b61b22be92f4"
  subscription_id = "b6bc018a-adec-45c6-bf16-bd8a24b927ac"

}