terraform {
  required_version = "1.4.6"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "3.37.0"
    }
    tls = {
      source = "hashicorp/tls"
      version = "~>4.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

/*
provider "azurerm" {
  features {}

  subscription_id = var.azure_subscription_id
  client_id       = var.azure_client_id
  client_secret   = var.azure_client_secret
  tenant_id       = var.azure_tenant_id
}
*/

# export environmental vars as TF_VAR_VAULT_ADDR and TF_VARS_VAULT_TOKEN
provider "vault" {
  address = var.VAULT_ADDR
  #token   = var.VAULT_TOKEN
}
