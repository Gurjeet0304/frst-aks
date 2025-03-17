provider "azurerm" {
  subscription_id = "38f02f2e-79b1-441d-af88-a350cfe813e9"

  storage_use_azuread             = true
  resource_provider_registrations = "none"
  features {
    app_configuration {
      #purge_soft_delete_on_destroy = local.is_prod ? false : true
      recover_soft_deleted = true
    }
    key_vault {
      purge_soft_delete_on_destroy               = true
      purge_soft_deleted_certificates_on_destroy = true
      purge_soft_deleted_keys_on_destroy         = true
      purge_soft_deleted_secrets_on_destroy      = true
    }
  }
}