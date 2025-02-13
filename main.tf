#================ Get Information About the Current Azure Client ==================#
# This data block fetches the current Azure client's subscription and tenant details.
data "azurerm_client_config" "current" {
}

#============== Resource Group for RAG (Retrieval-Augmented Generation) Solution =====================#
# Creating a Resource Group to organize and manage all resources for the RAG solution.
resource "azurerm_resource_group" "rg" {
  name     = var.rg_name        # The name of the resource group
  location = var.location       # The location/region where the resource group will be created
  tags     = var.tags           # Tags to categorize resources
}

#============= Create Azure Cognitive Search Resource for Indexing the Data ===================#
# Creating an Azure Cognitive Search service for indexing and searching data.
resource "azurerm_search_service" "ai-search-service" {
  name                           = var.ai_search_name                 # The name of the Azure Search service
  resource_group_name            = azurerm_resource_group.rg.name     # The resource group name where the service will reside
  location                       = var.location                      # The location/region for the search service
  sku                            = var.ai_search_sku                 # The SKU/size of the Azure Search service (e.g., "Basic", "Standard")

  local_authentication_enabled   = true                               # Enable local authentication
  authentication_failure_mode    = "http403"                          # Set the failure mode for authentication
}

#============= Create Azure OpenAI Resource for Deploying ChatGPT 4o LLM Model =================#
# Creating an Azure Cognitive Services resource with the OpenAI kind to deploy the ChatGPT 4o LLM model.
resource "azurerm_cognitive_account" "openai" {
  name                          = var.openai_name                    # The name of the OpenAI cognitive account
  location                      = var.location                       # The location/region for the cognitive account
  resource_group_name           = azurerm_resource_group.rg.name     # The resource group where this cognitive account will be created
  kind                          = "OpenAI"                           # Type of cognitive service (OpenAI)
  sku_name                      = var.openai_sku_name                # The SKU/size for the OpenAI service
  public_network_access_enabled = var.openai_public_network_access_enabled  # Toggle public network access
  tags                          = var.tags                           # Tags for organizing the cognitive account

  # Enabling system-assigned managed identity for the cognitive account
  identity {
    type = "SystemAssigned"
  }

  lifecycle {
    # Ignore changes to tags to avoid unnecessary updates
    ignore_changes = [
      tags
    ]
  }
}

#============= Deploy ChatGPT 4o LLM Model with Latest Version ==========#
# Creating a deployment for the GPT-4o model using the Azure OpenAI service.
resource "azurerm_cognitive_deployment" "deployment" {
  name                 = var.deployment_name                        # The name of the deployment
  cognitive_account_id = azurerm_cognitive_account.openai.id        # The ID of the cognitive account where the deployment will be created
  
  model {
    format  = "OpenAI"                                              # The format of the model
    name    = "gpt-4o"                                              # The name of the model (e.g., "gpt-4o")
    version = "2024-08-06"                                          # The version of the model
  }

  sku {
    name = "Standard"                                               # The SKU/size for the deployment
  }

  depends_on = [ azurerm_cognitive_account.openai ]                 # Ensure this deployment depends on the creation of the cognitive account
}

#============= Create a Storage Account for Data Storage and Access ==========#
# Creating an Azure Storage Account to store and manage data.
resource "azurerm_storage_account" "storage_account" {
  name                     = var.sa_name                            # The name of the storage account
  resource_group_name      = azurerm_resource_group.rg.name         # The resource group where the storage account will reside
  location                 = var.location                           # The location/region for the storage account
  account_kind             = var.storage_account_kind               # The kind/type of the storage account (e.g., "StorageV2")
  account_tier             = var.storage_account_tier               # The performance tier (e.g., "Standard", "Premium")
  account_replication_type = var.storage_account_replication_type   # The replication type (e.g., "LRS", "GRS")
  tags                     = var.tags                               # Tags for organizing the storage account

  lifecycle {
    # Ignore changes to tags to avoid unnecessary updates
    ignore_changes = [
        tags
    ]
  }
}

#============= Create a Private Storage Container in the Storage Account ==========#
# Creating a storage container within the storage account to store data securely.
resource "azurerm_storage_container" "storage_container" {
  name                  = var.container_name                       # The name of the storage container
  storage_account_id = azurerm_storage_account.storage_account.id # The name of the storage account to which the container belongs
  container_access_type = "private"                                # Setting the container access level to private
}
