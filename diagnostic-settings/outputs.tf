output "diagnostic_ids" {
  description = "Export diagnostic id "
  value       = azurerm_monitor_diagnostic_setting.diagnostic.*.id
}

output "log_categories" {
  description = "Export log_categories "
  value       = data.azurerm_monitor_diagnostic_categories.log_categories.logs
}


output "metric_categories" {
  description = "Export metric_categories "
  value       = data.azurerm_monitor_diagnostic_categories.log_categories.metrics
}

