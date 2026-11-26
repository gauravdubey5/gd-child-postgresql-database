output "postgresql_servers" {
  description = "The created PostgreSQL Flexible Servers."
  value       = azurerm_postgresql_flexible_server.servers
  sensitive   = true
}

output "postgresql_server_ids" {
  description = "Map of PostgreSQL Flexible Server IDs."
  value       = { for k, v in azurerm_postgresql_flexible_server.servers : k => v.id }
}

output "postgresql_server_fqdns" {
  description = "Map of PostgreSQL Flexible Server FQDNs."
  value       = { for k, v in azurerm_postgresql_flexible_server.servers : k => v.fqdn }
}

output "postgresql_databases" {
  description = "The created PostgreSQL Databases."
  value       = azurerm_postgresql_flexible_server_database.databases
}
