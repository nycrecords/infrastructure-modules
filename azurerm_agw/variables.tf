variable "location" {
  description = "(Optional) The location/region where the core network will be created. The full list of Azure regions can be found at https://azure.microsoft.com/regions"
  type        = string
  default     = ""
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group where the load balancer resources will be imported."
  type        = string
}

variable "vnet_name" {
  description = "(Required) The name of the virtual network where the load balancer resources are deployed."
  type        = string
}

variable "vnet_resource_group" {
  description = "(Required) The name of the resource group where the virtual network for the load balancer resources exists."
  type        = string
}

variable "frontend_subnet_name" {
  description = "(Required) The name of the subnet where the load balancer resources are deployed."
  type        = string
}

variable "prefix" {
  description = "(Required) Default prefix to use with your resource names."
  type        = string
  default     = "azure_lb"
}

variable "remote_port" {
  description = "Protocols to be used for remote vm access. [protocol, backend_port].  Frontend port will be automatically generated starting at 50000 and in the output."
  type        = map(any)
  default     = {}
}
