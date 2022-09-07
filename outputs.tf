output "sql_server_id" {
  description = "ID of the MS Sql Server"
  value       = azurerm_mssql_server.sql_server.id
}

output "sql_server_fqdn" {
  description = "FQDN of the MS Sql Server"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "name" {
  description = "Name of the MS Sql Server"
  value       = azurerm_mssql_server.sql_server.name
}

output "admin_login_username" {
  description = "Admin Login Username of the MS Sql Server"
  value       = azurerm_mssql_server.sql_server.administrator_login
  sensitive   = true
}

output "admin_login_password" {
  description = "Admin Login Password of the MS Sql Server"
  value       = azurerm_mssql_server.sql_server.administrator_login_password
  sensitive   = true
}

output "restorable_dropped_database_ids" {
  description = "A list of dropped restorable database IDs on this server"
  value       = azurerm_mssql_server.sql_server.restorable_dropped_database_ids
}

output "identity_pricipal_id" {
  description = "System Assigned Identity Principal ID"
  value       = try(azurerm_mssql_server.sql_server.identity[0].principal_id, "")

}
