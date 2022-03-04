output "id" {
  description = "Specifies the resource id of the network security group"
  value       = azurerm_network_security_group.nsg.id
}

output "diagnostic" {
  description = "nsg diagnostic"
  value       = module.diagnostic
}