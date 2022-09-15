# Copyright 2022 Nexient LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

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
  description = "Number of days to retain the logs in the storage account. Required if extended_auditing_enabled=true"
  type        = number
  default     = 30
}

variable "storage_endpoint" {
  description = "The blob storage (primary_blob_endpoint) that will hold the extended auditing logs. Required if extended_auditing_enabled=true"
  type        = string
  default     = ""
}

variable "storage_account_access_key" {
  description = "The access key (primary_access_key) of the storage account. Required if extended_auditing_enabled=true"
  type        = string
  default     = ""
}

variable "allow_access_to_azure_services" {
  description = "If true, it enables all the azure services to access the database server. "
  type        = bool
  default     = true
}

variable "allow_firewall_ip_list" {
  description = "A list of IP Address to whitelist, in order to access the database server"
  type        = list(string)
  default     = []
}

variable "allow_firewall_ip_ranges_list" {
  description = "A list of IP Address ranges to whitelist, in order to access the database server"
  type = list(object({
    start_ip_address = string
    end_ip_address   = string
  }))

  default = []
}

variable "custom_tags" {
  description = "A map of custom tags to be attached to this SQL Server instance"
  type        = map(string)
  default     = {}
}
