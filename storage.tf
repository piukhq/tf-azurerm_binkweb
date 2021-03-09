resource "azurerm_storage_account" "storage" {
    name = "bink${var.location}${var.environment}web"
    resource_group_name = azurerm_resource_group.rg.name
    location = azurerm_resource_group.rg.location
    tags = var.tags

    account_kind = "StorageV2"
    account_tier = var.storage_account_tier
    account_replication_type = var.storage_account_replication_type
    min_tls_version = "TLS1_2"
    enable_https_traffic_only = true
    allow_blob_public_access = true

    static_website {
        index_document = "index.html"
        #error_404_document = "index.html"
    }
}

resource "azurerm_monitor_diagnostic_setting" "storage" {
    name = "logs"
    target_resource_id = "${azurerm_storage_account.storage.id}/blobServices/default"
    eventhub_name = "azurestorage"
    eventhub_authorization_rule_id = var.eventhub_authid

    log {
        category = "StorageRead"
        enabled = true
        retention_policy {
            days = 0
            enabled = false
        }
    }
    log {
        category = "StorageWrite"
        enabled = true
        retention_policy {
            days = 0
            enabled = false
        }
    }
    log {
        category = "StorageDelete"
        enabled = true
        retention_policy {
            days = 0
            enabled = false
        }
    }

    metric {
        category = "Capacity"
        enabled = false
        retention_policy {
            days = 0
            enabled = false
        }
    }

    metric {
        category = "Transaction"
        enabled = false
        retention_policy {
            days = 0
            enabled = false
        }
    }
}
