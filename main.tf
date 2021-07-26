terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.69.0"
      configuration_aliases = [ azurerm.core ]
    }
  }
}

resource "azurerm_resource_group" "rg" {
    name = var.resource_group_name
    location = var.location
    tags = var.tags
}

provider "azurerm" {
    alias = "core"
}
