locals {
  base_name = "${var.service}-${local.environment}-${var.region}"

  deployment_region = local.regions[var.region]

  regions = {
    aue = {
      name       = "Australia East"
      short_name = "aue"
      location   = "australiaeast"
    }


  }

  environment = terraform.workspace == "default" ? "dev" : lower(terraform.workspace)
  tag = merge({
    deployment_method = "terraform"
    environment       = local.environment
    service           = var.service
    owner             = "Gurjeet Singh"
  })
}