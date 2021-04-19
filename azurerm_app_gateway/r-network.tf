data "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  resource_group_name = var.nsg_resource_group_name
}

resource "azurerm_network_security_rule" "web" {
  count = var.create_nsg && var.create_nsg_https_rule ? 1 : 0

  name = local.nsr_https_name

  resource_group_name         = var.subnet_resource_group_name != "" ? var.subnet_resource_group_name : var.resource_group_name
  network_security_group_name = data.azurerm_network_security_group.nsg.name

  priority  = 100
  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  source_port_range       = "*"
  destination_port_ranges = ["443"]

  source_address_prefix      = var.nsr_https_source_address_prefix != "*" ? var.nsr_https_source_address_prefix : "*"
  destination_address_prefix = "*"
}


resource "azurerm_network_security_rule" "allow_health_probe_app_gateway" {
  count = var.create_nsg && var.create_nsg_healthprobe_rule ? 1 : 0

  name = local.nsr_healthcheck_name

  resource_group_name         = var.subnet_resource_group_name != "" ? var.subnet_resource_group_name : var.resource_group_name
  network_security_group_name = data.azurerm_network_security_group.nsg.name

  priority  = 101
  direction = "Inbound"
  access    = "Allow"
  protocol  = "Tcp"

  source_port_range       = "*"
  destination_port_ranges = ["65200-65535"]

  source_address_prefix      = "Internet"
  destination_address_prefix = "*"
}
