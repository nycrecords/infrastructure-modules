data "azurerm_resource_group" "rg" {
  name = var.resource_group_name
}

data "azurerm_subnet" "subnet" {
  name                 = var.frontend_subnet_name
  virtual_network_name = var.vnet_name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

output "subnet_id" {
  value = data.azurerm_subnet.example.id
}

resource "azurerm_lb" "lb" {
  name                = "${var.prefix}-lb"
  resource_group_name = data.azurerm_resource_group.rg.name
  location            = coalesce(var.location, data.azurerm_resource_group.rg.location)
  sku                 = var.lb_sku
  tags                = var.tags

  frontend_ip_configuration {
    name                          = var.frontend_name
    subnet_id                     = data.azurerm_subnet.subnet.id
    private_ip_address            = var.frontend_private_ip_address
    private_ip_address_allocation = var.frontend_private_ip_address_allocation
  }
}

resource "azurerm_lb_backend_address_pool" "lb" {
  name                = "BackendAddressPool"
  resource_group_name = data.azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.lb.id
}

resource "azurerm_lb_nat_rule" "lb" {
  count                          = length(var.remote_port)
  name                           = "VM-${count.index}"
  resource_group_name            = data.azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = "tcp"
  frontend_port                  = "5000${count.index + 1}"
  backend_port                   = element(var.remote_port[element(keys(var.remote_port), count.index)], 1)
  frontend_ip_configuration_name = var.frontend_name
}

resource "azurerm_lb_probe" "lb" {
  count               = length(var.lb_probe)
  name                = element(keys(var.lb_probe), count.index)
  resource_group_name = data.azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_lb.lb.id
  protocol            = element(var.lb_probe[element(keys(var.lb_probe), count.index)], 0)
  port                = element(var.lb_probe[element(keys(var.lb_probe), count.index)], 1)
  interval_in_seconds = var.lb_probe_interval
  number_of_probes    = var.lb_probe_unhealthy_threshold
  request_path        = element(var.lb_probe[element(keys(var.lb_probe), count.index)], 2)
}

resource "azurerm_lb_rule" "lb" {
  count                          = length(var.lb_port)
  name                           = element(keys(var.lb_port), count.index)
  resource_group_name            = data.azurerm_resource_group.rg.name
  loadbalancer_id                = azurerm_lb.lb.id
  protocol                       = element(var.lb_port[element(keys(var.lb_port), count.index)], 1)
  frontend_port                  = element(var.lb_port[element(keys(var.lb_port), count.index)], 0)
  backend_port                   = element(var.lb_port[element(keys(var.lb_port), count.index)], 2)
  frontend_ip_configuration_name = var.frontend_name
  enable_floating_ip             = false
  backend_address_pool_id        = azurerm_lb_backend_address_pool.lb.id
  idle_timeout_in_minutes        = 5
  probe_id                       = element(azurerm_lb_probe.lb.*.id, count.index)
}
