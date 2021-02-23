resource "azurerm_cdn_profile" "web" {
  name                = "bink${var.location}${var.environment}web"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku                 = "Standard_Microsoft"

  tags = var.tags
}

resource "azurerm_cdn_endpoint" "binkweb" {
  depends_on = [ azurerm_dns_cname_record.endpoint_record ]

  name                = "binkweb"
  profile_name        = azurerm_cdn_profile.web.name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  is_http_allowed = false
  is_https_allowed = true

  origin {
    name      = "bink${var.location}${var.environment}web"
    host_name = azurerm_storage_account.storage.primary_web_endpoint
  }
}

