# Azure OpenAI and Azure AI Search Deployment with Terraform

This Terraform configuration deploys an AI solution on Azure, including:
- Azure Resource Group
- Azure Cognitive Search service
- Azure OpenAI resource for deploying ChatGPT 4o LLM model
- Azure Storage Account and Storage Container

## Prerequisites

Install the following before you start:
- [Terraform](https://www.terraform.io/downloads.html)
- [Azure CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli)

Ensure you have the proper Azure permissions to create resources.

## Terraform Configuration Overview

This setup creates the following resources:
- Resource Group
- Azure Cognitive Search
- Azure OpenAI Cognitive Account
- Azure Storage Account and Container

## Provider Configuration

The `provider.tf` file configures the Azure provider and backend for state management:

```hcl
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.00"
    }
  }
  backend "azurerm" {
    resource_group_name   = "rg-state"
    storage_account_name  = "satfstaterxt"
    container_name        = "catfstaterxt"
    key                   = "terraform.tfstate"
  }
}

provider "azurerm" {
  features {}
}
```

This ensures that the Terraform state is stored in an Azure Blob Storage container for remote state management.

## Setup Instructions
1. Clone the Repository to your local direcotory
   
   ```bash
   git clone https://github.com/anoopkum/openai-terraform
   cd local_directory
   ```
2. Edit a terraform.tfvars file with the your choice values:

```hcl
rg_name         = "RG-openAI-demo"
ai_search_name  = "ai-search-rxt-demo"
openai_name     = "openai-rxt-demo"
sa_name         = "openaisademo01"
container_name  = "democontainer"
location        = "eastus"
deployment_name = "chatgpt4o"
```
3. Initialize Terraform
   
   ```bash
   terraform init
   ```
4.  Review and Apply the Plan

   ```bash
   terraform plan
   terraform apply
```

## File Structure

```plaintext
.
├── main.tf                 # Main Terraform configuration
├── variables.tf            # Variable definitions
├── provider.tf             # Provider and backend configuration
├── terraform.tfvars        # Variable values
├── .gitignore              # Git ignore file
└── README.md               # This readme file
```

## References

- [Azure OpenAI Service](https://learn.microsoft.com/en-us/azure/cognitive-services/openai/overview)
- [Azure Cognitive Search](https://learn.microsoft.com/en-us/azure/search/search-what-is-azure-search)

