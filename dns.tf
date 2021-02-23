resource "azurerm_dns_cname_record" "binkweb_endpoint_record" {
    provider = azurerm.core

    name = var.binkweb_dns_record
    zone_name = var.public_dns_zone.dns_zone_name
    resource_group_name = var.public_dns_zone.resource_group_name
    ttl = 300
    record = "bink${var.location}${var.environment}web.azureedge.net"
}
