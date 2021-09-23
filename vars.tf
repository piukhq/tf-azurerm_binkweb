variable resource_group_name { type = string }
variable location { type = string }
variable tags { type = map(string) }
variable environment { type = string }
variable eventhub_authid { type = string }
variable ip_whitelist {
    type = list
    default = ["0.0.0.0/0"]
}
variable binkweb_dns_record { type = string }
variable public_dns_zone { type = object({
    resource_group_name = string
    dns_zone_name = string
}) }

variable storage_account_tier {
    type = string
    default = "Standard"
}

variable storage_account_replication_type {
    type = string
    default = "ZRS"
}
