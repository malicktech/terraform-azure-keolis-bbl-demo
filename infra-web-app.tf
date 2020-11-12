# Create a new Resource Group

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-example-rg"
  location = var.location

  tags = {
    Environment = "Keolis"
    Team        = "Fabrik"
  }
}

# Create an App Service Plan with Linux

resource "azurerm_app_service_plan" "main" {
  name                = "${var.prefix}-example-app-service-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Standard"
    size = "S1"
  }
}

# Create an Azure Web App for Containers in that App Service Plan

resource "azurerm_app_service" "main" {
  name                = "${var.prefix}-example-app-service"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.main.id
  https_only          = true

  # Configure Docker Image to load on start
  site_config {
    always_on        = "true"
    linux_fx_version = "DOCKER|${var.docker_image}:${var.docker_image_tag}"
  }

  app_settings = {
    # Do not attach Storage by default
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"

    # map container 8080 port
    "WEBSITES_PORT"                       = "8080"
    "WEBSITES_CONTAINER_START_TIME_LIMIT" = "600"

    "DOCKER_REGISTRY_SERVER_URL" = "https://index.docker.io"

    /*
    # Settings for private Container Registires  
    DOCKER_REGISTRY_SERVER_URL      = ""
    DOCKER_REGISTRY_SERVER_USERNAME = ""
    DOCKER_REGISTRY_SERVER_PASSWORD = ""
    */

    # These are app specific environment variables
    "SPRING_PROFILES_ACTIVE"     = "prod"
    "SPRING_DATASOURCE_URL"      = "jdbc:mysql://${azurerm_mysql_server.example.fqdn}:3306/${azurerm_mysql_database.example.name}?useUnicode=true&characterEncoding=utf8&useSSL=true&useLegacyDatetimeCode=false&serverTimezone=UTC&createDatabaseIfNotExist=true"
    "SPRING_DATASOURCE_USERNAME" = "${azurerm_mysql_server.example.administrator_login}@${azurerm_mysql_server.example.name}"
    "SPRING_DATASOURCE_PASSWORD" = azurerm_mysql_server.example.administrator_login_password
  }
}

