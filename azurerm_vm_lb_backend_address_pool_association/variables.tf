variable "network_interface_name" {
  description = "(Required) Name of the network interface to connect to the load balancer"
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in where the network interface is created."
  type        = string
}

variable "ip_configuration_name" {
  description = "(Required) The name of the ip configuration"
  type        = string
}

variable "load_balancer_name" {
  description = "(Required) Name of the load balancer that the app will be connected to."
  type        = string
  default     = ""
}

variable "backend_address_pool_name" {
  description = "(Optional) Name of the load balancer that the app will be connected to."
  type        = string
  default     = ""
}
