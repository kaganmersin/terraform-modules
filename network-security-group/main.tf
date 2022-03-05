
resource "azurerm_network_security_group" "nsg" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags

  dynamic "security_rule" {
    for_each = try(var.security_rules, [])
    content {
      name                                       = try(security_rule.value.name, null)
      priority                                   = try(security_rule.value.priority, null)
      direction                                  = try(security_rule.value.direction, null)
      access                                     = try(security_rule.value.access, null)
      protocol                                   = try(security_rule.value.protocol, null)
      source_port_range                          = try(security_rule.value.source_port_range, null)
      source_port_ranges                         = try(security_rule.value.source_port_ranges, null)
      destination_port_range                     = try(security_rule.value.destination_port_range, null)
      destination_port_ranges                    = try(security_rule.value.destination_port_ranges, null)
      source_address_prefix                      = try(security_rule.value.source_address_prefix, null)
      source_address_prefixes                    = try(security_rule.value.source_address_prefixes, null)
      destination_address_prefix                 = try(security_rule.value.destination_address_prefix, null)
      destination_address_prefixes               = try(security_rule.value.destination_address_prefixes, null)
      source_application_security_group_ids      = try(security_rule.value.source_application_security_group_ids, null)
      destination_application_security_group_ids = try(security_rule.value.destination_application_security_group_ids, null)
    }
  }
}

# We can not use count directly in azurerm_network_interface_security_group_association and  azurerm_subnet_network_security_group_association
# because of  https://github.com/hashicorp/terraform/issues/26078

data "azurerm_subnet" "subnet" {
  count                = var.subnet_name != null ? 1 : 0
  name                 = var.subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "nsg_subnet_associate" {
  count                     = var.subnet_name != null || var.subnet_id != null ? 1 : 0
  subnet_id                 = var.subnet_id != null ? var.subnet_id : data.azurerm_subnet.subnet[0].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

data "azurerm_network_interface" "nic" {
  count               = var.network_interface_name != null ? 1 : 0
  name                = var.network_interface_name
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_interface_security_group_association" "nsg_nic_associate" {
  count                     = var.network_interface_name != null || var.network_interface_id != null ? 1 : 0
  network_interface_id      = var.network_interface_id != null ? var.network_interface_id : data.azurerm_network_interface.nic[0].id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

module "diagnostic" {
  source                     = "../diagnostic-settings"
  target_resource_id         = azurerm_network_security_group.nsg.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  retention_days             = var.retention_days
  name                       = "diag-${var.name}"
}