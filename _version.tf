terraform {
  required_version = ">= 1.4"

  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "2.38"
    }

    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.12.0"
    }

    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

    azapi = {
      source  = "azure/azapi"
      version = "1.15.0"
    }
  }
}
