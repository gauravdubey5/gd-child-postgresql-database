locals {
  postgresql_databases = merge([
    for srv_key, srv in var.postgresql_servers : {
      for db in lookup(srv, "databases", []) :
      "${srv_key}-${try(db.name, db)}" => {
        server_key = srv_key
        name       = try(db.name, db)
        collation  = try(db.collation, "en_US.utf8")
        charset    = try(db.charset, "UTF8")
      }
    }
  ]...)
}

resource "azurerm_postgresql_flexible_server" "servers" {
  for_each                      = var.postgresql_servers
  name                          = each.value.name
  resource_group_name           = each.value.resource_group_name
  location                      = each.value.location
  version                       = lookup(each.value, "version", "16")
  sku_name                      = lookup(each.value, "sku_name", "B_Standard_B1ms")
  storage_mb                    = lookup(each.value, "storage_mb", 32768)
  administrator_login           = lookup(each.value, "administrator_login", "pgadmin")
  administrator_password        = lookup(each.value, "administrator_password", null)
  delegated_subnet_id           = lookup(each.value, "delegated_subnet_id", null) != null ? each.value.delegated_subnet_id : (lookup(each.value, "subnet_name", null) != null ? data.azurerm_subnet.subnets[each.key].id : null)
  private_dns_zone_id           = lookup(each.value, "private_dns_zone_id", null)
  public_network_access_enabled = lookup(each.value, "public_network_access_enabled", true)
  backup_retention_days         = lookup(each.value, "backup_retention_days", 7)
  geo_redundant_backup_enabled  = lookup(each.value, "geo_redundant_backup_enabled", false)
  zone                          = lookup(each.value, "zone", "1")
  tags                          = lookup(each.value, "tags", {})
}

resource "azurerm_postgresql_flexible_server_database" "databases" {
  for_each  = local.postgresql_databases
  name      = each.value.name
  server_id = azurerm_postgresql_flexible_server.servers[each.value.server_key].id
  collation = each.value.collation
  charset   = each.value.charset
}
