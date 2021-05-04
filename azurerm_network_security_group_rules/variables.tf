variable "nsg_resource_group_name" {
  description = "Network Security Group Resource group name"
  type        = string
}

variable "nsg_name" {
  description = "Network Security Group name"
  type        = string
}

variable "nsg_rules" {
  description = "Network Security Group Rules to create. Format should be <Rule Name> = [priority, direction, access, protocol, source_port_range, destination_port_ranges, source_address_prefix, destination_address_prefix]"
  type = map(any)
}
