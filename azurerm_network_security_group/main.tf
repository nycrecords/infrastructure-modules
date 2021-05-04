data "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  resource_group_name = var.nsg_resource_group_name
}

resource "azurerm_network_security_rule" "rule" {
  count = length(var.nsg_rules)

  name = element(key(var.nsg_rules), count.index)

  resource_group_name         = var.nsg_resource_group_name
  network_security_group_name = data.azurerm_network_security_group.nsg.name

  priority  = element(var.nsg_rules[element(keys(var.nsg_rules), count.index)], 1)
  direction = element(var.nsg_rules[element(keys(var.nsg_rules), count.index)], 2)
  access    = element(var.nsg_rules[element(keys(var.nsg_rules), count.index)], 3)
  protocol  = element(var.nsg_rules[element(keys(var.nsg_rules), count.index)], 4)

  source_port_range       = element(var.nsg_rules[element(keys(var.nsg_rules), count.index)], 5)
  destination_port_ranges = element(var.nsg_rules[element(keys(var.nsg_rules), count.index)], 6)

  source_address_prefix      = element(var.nsg_rules[element(keys(var.nsg_rules), count.index)], 7)
  destination_address_prefix = element(var.nsg_rules[element(keys(var.nsg_rules), count.index)], 8)
}
