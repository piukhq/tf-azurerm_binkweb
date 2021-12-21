variable resource_group_name { type = string }
variable location { type = string }
variable environment { type = string }

variable "storage_accounts" {
    type = map(object({
        name = string
    }))
    default = {}
}

variable "eventhub_authid" { type = string }

variable "loganalytics_id" { type = string }
