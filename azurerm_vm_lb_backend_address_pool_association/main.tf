data "azurerm_network_interface" "network_interface" {
  name                = var.network_interface_name
  resource_group_name = var.resource_group_name
}

data "azurerm_lb" "load_balancer" {
  name                = var.load_balancer_name
  resource_group_name = var.resource_group_name
}

data "azurerm_lb_backend_address_pool" "backend_address_pool" {
  loadbalancer_id = data.azurerm_lb.load_balancer.id
  name            = var.backend_address_pool_name
}

resource "azurerm_network_interface_backend_address_pool_association" "backend_address_pool_association" {
  network_interface_id    = data.azurerm_network_interface.network_interface.id
  ip_configuration_name   = var.ip_configuration_name
  backend_address_pool_id = data.azurerm_lb_backend_address_pool.backend_address_pool.id
}
