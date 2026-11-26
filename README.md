# gd-child-postgresql-database: Azure PostgreSQL Flexible Server Terraform Module

This child module creates and manages Azure Database for PostgreSQL Flexible Servers and their logical databases.

Part of the **Azure Parent–Child Infrastructure Architecture** under GitHub account `gauravdubey5`.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| `postgresql_servers` | Mapping of PostgreSQL Flexible Server configurations (`name`, `resource_group_name`, `location`, `administrator_login`, `administrator_password`, optional `databases`, etc.) | `any` | `{}` | yes |

## Outputs

| Name | Description |
|------|-------------|
| `postgresql_servers` | The created PostgreSQL Flexible Servers (marked sensitive) |
| `postgresql_server_ids` | Non-sensitive map of PostgreSQL Server IDs |
| `postgresql_server_fqdns` | Non-sensitive map of PostgreSQL Server FQDNs |
| `postgresql_databases` | The created PostgreSQL Databases |
