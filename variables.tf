variable "resource_group" {
  description = "Target Resource Group where all the infrastructure for this module will be created"
  type = object({
    name     = string
    location = string
  })
  default = {
    name     = "deb-test-devops"
    location = "eastus"
  }
}

variable "sql_server_name" {
  description = "Name of the Microsoft SQL server name"
  type        = string
}

variable "sql_server_version" {
  description = "Version of the Microsoft SQL server"
  type        = string
  default     = "12.0"
  validation {
    condition     = contains(["2.0", "12.0"], var.sql_server_version)
    error_message = "The sql_server_version must be one of '2.0' or '12.0'."
  }
}

variable "administrator_login_username" {
  description = "The admin username for the server"
  type        = string
  sensitive   = true
}

variable "administrator_login_password" {
  description = "The admin password for the server"
  type        = string
  sensitive   = true
}

variable "connection_policy" {
  description = "The connection policy for the server. Possible values are Default, Proxy or Redirect"
  type        = string
  default     = "Default"
  validation {
    condition     = contains(["Default", "Proxy", "Redirect"], var.connection_policy)
    error_message = "The connection_policy must be one of 'Default', 'Proxy' or 'Redirect'."
  }
}

variable "enable_system_managed_identity" {
  description = "Should the system managed identity be enabled for SQL Server?"
  type        = bool
  default     = true
}

variable "minimum_tls_version" {
  description = "Minimum TLS version for the server. Default is 1.2. Possible values are 1.0, 1.1, 1.2 or Disabled"
  type        = string
  default     = "1.2"
  validation {
    condition     = contains(["1.0", "1.1", "1.2", "Disabled"], var.minimum_tls_version)
    error_message = "The minimum_tls_version must be one of '1.0', '1.1', '1.2' or 'Disabled'."
  }
}

variable "public_network_access_enabled" {
  description = "Whether public network access is enabled for this server? Defaults to true"
  type        = bool
  default     = true
}

variable "outbound_network_restriction_enabled" {
  description = "Whether outbound network traffic is restricted for this server. Defaults to false"
  type        = bool
  default     = false

}

variable "extended_auditing_enabled" {
  description = "Whether the extended auditing should be enabled?"
  type        = bool
  default     = false
}

variable "retention_in_days" {
  description = "Number of days to retain the logs in the storage account"
  type        = number
  default     = 30
}

variable "storage_endpoint" {
  description = "The blob storage that will hold the extended auditing logs"
  type        = string
  default     = ""
}

variable "storage_account_access_key" {
  description = "The access key of the storage account"
  type        = string
  default     = ""
}

variable "custom_tags" {
  description = "A map of custom tags to be attached to this SQL Server instance"
  type        = map(string)
  default     = {}
}
