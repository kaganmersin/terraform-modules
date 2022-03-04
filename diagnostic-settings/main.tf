data "azurerm_monitor_diagnostic_categories" "log_categories" {
  resource_id = var.target_resource_id
}



resource "azurerm_monitor_diagnostic_setting" "diagnostic" {
  name                       = lower("diagnostic-${var.name}")
  target_resource_id         = var.target_resource_id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  dynamic "log" {
    for_each = data.azurerm_monitor_diagnostic_categories.log_categories.logs
    content {
      category = log.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = var.retention_days
      }
    }
  }

  #Some objects (eg. nsg) has no exportable metrics. That is why we can not define Allmetrics in below
  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.log_categories.metrics
    content {
      category = metric.value
      enabled  = true

      retention_policy {
        enabled = true
        days    = var.retention_days
      }
    }
  }

}


