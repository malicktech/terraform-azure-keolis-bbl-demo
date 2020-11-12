terraform {
  # https://www.terraform.io/docs/configuration/terraform.html#specifying-provider-requirements
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 2.26"
    }
  }

  # https://www.terraform.io/docs/configuration/terraform.html#specifying-a-required-terraform-version
  required_version = ">=0.12.28"
}
