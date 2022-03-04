output "addon_profile" {
  description = "Export whole addon profiles "
  value       = azurerm_kubernetes_cluster.aks_cluster.addon_profile
}


output "id" {
  description = "Export cluster id "
  value       = azurerm_kubernetes_cluster.aks_cluster.id
}


output "aks_name" {
  description = "Export aks_name "
  value       = azurerm_kubernetes_cluster.aks_cluster.name
}

output "resource_group_name" {
  description = "Export aks_name "
  value       = azurerm_kubernetes_cluster.aks_cluster.resource_group_name
}



output "fqdn" {
  description = "Export fqdn of AKS"
  value       = azurerm_kubernetes_cluster.aks_cluster.fqdn
}

output "node_resource_group" {
  description = "Export fqdn of AKS"
  value       = azurerm_kubernetes_cluster.aks_cluster.node_resource_group
}