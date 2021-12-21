terraform {
    required_providers {
        azurerm = {
            source  = "hashicorp/azurerm"
            version = ">= 2.69.0"
            configuration_aliases = [ azurerm ]
        }
    }
}

resource "azurerm_storage_account" "i" {
    for_each = var.storage_accounts

    name = each.value.name
    resource_group_name = var.resource_group_name
    location = var.location
    tags = {
        "Environment" = var.environment
    }

    account_kind = "StorageV2"
    account_tier = "Standard"
    account_replication_type = "ZRS"
    min_tls_version = "TLS1_2"
    enable_https_traffic_only = true
    allow_blob_public_access = true

    static_website {
        index_document = "index.html"
        error_404_document = "index.html"
    }
}

resource "azurerm_monitor_diagnostic_setting" "i" {
    for_each = var.storage_accounts

    name = "logs"
    target_resource_id = "${azurerm_storage_account.i[each.key].id}/blobServices/default"
    eventhub_name = "azurestorage"
    eventhub_authorization_rule_id = var.eventhub_authid
    log_analytics_workspace_id = var.loganalytics_id

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
