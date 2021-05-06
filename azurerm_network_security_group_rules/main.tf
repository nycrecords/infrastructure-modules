data "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  resource_group_name = var.nsg_resource_group_name
}

resource "azurerm_network_security_rule" "rule" {
  count = length(var.nsg_rules)

  name = element(var.nsg_rules, count.index).name

  resource_group_name         = var.nsg_resource_group_name
  network_security_group_name = data.azurerm_network_security_group.nsg.name

  priority  = element(var.nsg_rules, count.index).prio` rity
  direction = element(var.nsg_rules, count.index).direction
  access    = element(var.nsg_rules, count.index).access
  protocol  = element(var.nsg_rules, count.index).protocol

  source_port_range       = element(var.nsg_rules, count.index).source_port_range
  destination_port_ranges = element(var.nsg_rules, count.index).destination_port_ranges

  source_address_prefix      = element(var.nsg_rules, count.index).source_address_prefix
  destination_address_prefix = element(var.nsg_rules, count.index).destination_address_prefix
}
