variable "nsg_resource_group_name" {
  description = "Network Security Group Resource group name"
  type        = string
}

variable "nsg_name" {
  description = "Network Security Group name"
  type        = string
}

variable "nsg_rules" {
  description = "Network Security Group Rules to create."
  type = list(
    object({
      name = string,
      priority = string,
      direction = string,
      access = string,
      protocol = string,
      source_port_range = string,
      destination_port_ranges = list(string),
      source_address_prefix = string,
      destination_address_prefix = string
    }),
  )
}
