# Terraform keolis BBL demo

Terraform configuration to deploy n-tier infra  wit webb app + database to azure 

## Prérequis

- Install terraform
- Install Azure CLI

## cmd to build infrastructure

create a `terraform.tfvars` (copy `terraform.tfvars.example`)  and set varaibles.

```bash

# Authenticate using the Azure CLI
$ az login

# Initialize your Terraform config
$ terraform init

# Plan your Terraform Run
$ terraform plan

# Apply your Terraform Config
$ terraform apply

# Destroy your infrastructure
terraform destroy

```

after deploy : check url output and test jhipster app deployed (creds : admin/admin)

## links

Tuto Get Started Azure
https://learn.hashicorp.com/collections/terraform/azure-get-started

Terraform on Azure documentation
https://docs.microsoft.com/en-us/azure/developer/terraform/

Terraform Azure provider
https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs