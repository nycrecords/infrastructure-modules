output "azurerm_resource_group_tags" {
  description = "the tags provided for the resource group"
  value       = data.azurerm_resource_group.rg.tags
}

output "azurerm_resource_group_name" {
  description = "name of the resource group provisioned"
  value       = data.azurerm_resource_group.rg.name
}

