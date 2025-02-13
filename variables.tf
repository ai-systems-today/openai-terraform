
variable "location" {
  description = "Specifies the location for the resource group and all the resources"
  default     = "eastus"
  type        = string
}

variable "rg_name" {
  description = "Specifies the resource group name"
  default     = ""
  type        = string
}

variable "sa_name" {
  description = "Specifies the stoage account name"
  default     = ""
  type        = string
}


variable "storage_account_kind" {
  description = "(Optional) Specifies the account kind of the storage account"
  default     = "StorageV2"
  type        = string

  validation {
    condition     = contains(["Storage", "StorageV2"], var.storage_account_kind)
    error_message = "The account kind of the storage account is invalid."
  }
}

variable "storage_account_tier" {
  description = "(Optional) Specifies the account tier of the storage account"
  default     = "Standard"
  type        = string

  validation {
    condition     = contains(["Standard", "Premium"], var.storage_account_tier)
    error_message = "The account tier of the storage account is invalid."
  }
}

variable "storage_account_replication_type" {
  description = "(Optional) Specifies the replication type of the storage account"
  default     = "LRS"
  type        = string

  validation {
    condition     = contains(["LRS", "ZRS", "GRS", "GZRS", "RA-GRS", "RA-GZRS"], var.storage_account_replication_type)
    error_message = "The replication type of the storage account is invalid."
  }
}

variable "container_name" {
  description = "Specifies the container name"
  default     = ""
  type        = string
}


variable "tags" {
  description = "(Optional) Specifies tags for all the resources"
  default = {
    createdWith = "Terraform"
  }
}

variable "deployment_name" {
  type    = string
  default = ""
}

variable "ai_search_name" {
  description = "Specifies the resource group name"
  default     = ""
  type        = string
}

variable "ai_search_sku" {
  description = "Specifies the resource group name"
  default     = "standard"
  type        = string
}

variable "openai_name" {
  description = "(Required) Specifies the name of the Azure OpenAI Service"
  type        = string
  default     = ""
}

variable "openai_sku_name" {
  description = "(Optional) Specifies the sku name for the Azure OpenAI Service"
  type        = string
  default     = "S0"
}


variable "openai_public_network_access_enabled" {
  description = "(Optional) Specifies whether public network access is allowed for the Azure OpenAI Service"
  type        = bool
  default     = true
}

