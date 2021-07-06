terraform {
  backend "azurerm" {
    storage_account_name = ""
    container_name       = ""
    key                  = ".tfstate"
    resource_group_name  = "LATAMPSSandbox"
  }
}
