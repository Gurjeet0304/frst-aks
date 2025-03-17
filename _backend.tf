terraform {
  backend "azurerm" {
    subscription_id      = "38f02f2e-79b1-441d-af88-a350cfe813e9" 
    resource_group_name  = "terraform"
    storage_account_name = "terraformfrst"
    container_name       = "akstfstate"
    key                  = "terraform.tfstate"
    use_azuread_auth     = true
  }
}