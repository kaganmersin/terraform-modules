variable "name" {
  description = "(Required) Specifies the name of the network security group"
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Specifies the resource group name of the network security group"
  type        = string
}

variable "location" {
  description = "(Required) Specifies the location of the network security group"
  type        = string
}

variable "security_rules" {
  description = "Security rules for the network security group using this format name = [priority, direction, access, protocol, source_port_range, destination_port_range, source_address_prefix, destination_address_prefix, description]"
  type        = any
  default     = []
}


variable "tags" {
  description = "(Optional) Specifies the tags of the network security group"
  default     = {}
}



variable "subnet_id" {
  type    = string
  default = null
}


variable "network_interface_id" {
  type    = string
  default = null
}


variable "network_interface_name" {
  type    = string
  default = null
}

variable "subnet_name" {
  type    = string
  default = null
}

variable "vnet_name" {
  type    = string
  default = null
}


variable "log_analytics_workspace_id" {
  type    = string
  default = null
}

variable "retention_days" {
  type    = number
  default = null
}