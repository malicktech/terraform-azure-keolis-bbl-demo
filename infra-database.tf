resource "azurerm_mysql_server" "example" {
  name                = "${var.prefix}-example-mysql-server"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  administrator_login          = var.mysql_administrator_login
  administrator_login_password = var.mysql_administrator_login_password

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

  ssl_enforcement_enabled = true
}

resource "azurerm_mysql_database" "example" {
  name                = "${var.prefix}-example-database"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.example.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}

# This rule is to enable the 'Allow access to Azure services' checkbox
resource "azurerm_mysql_firewall_rule" "main" {
  name                = "firewall-allow-azure-service"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.example.name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "0.0.0.0"
}

resource "azurerm_mysql_firewall_rule" "allowlocal" {
  name                = "firewall-allow-local-pc"
  resource_group_name = azurerm_resource_group.rg.name
  server_name         = azurerm_mysql_server.example.name
  start_ip_address    = var.firewall_ip_address
  end_ip_address      = var.firewall_ip_address
}