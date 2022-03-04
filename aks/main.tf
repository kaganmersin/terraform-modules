
resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  kubernetes_version  = var.kubernetes_version
  dns_prefix                      = var.dns_prefix_managed_cluster
  private_cluster_enabled         = var.private_cluster_enabled
  sku_tier                        = var.sku_tier
  api_server_authorized_ip_ranges = var.aks_api_server_authorized_ip_ranges
  local_account_disabled          = var.local_account_disabled

  default_node_pool {
    name           = var.default_node_pool_name
    type           = var.default_node_pool_type
    vm_size        = var.default_node_pool_vm_size
    vnet_subnet_id = var.default_node_pool_nodes_subnet_id
    availability_zones     = var.default_node_pool_availability_zones
    node_labels            = var.default_node_pool_node_labels
    enable_auto_scaling    = var.default_node_pool_enable_auto_scaling
    enable_host_encryption = var.default_node_pool_enable_host_encryption
    max_pods               = var.default_node_pool_max_pods
    max_count              = var.default_node_pool_max_node_count
    min_count              = var.default_node_pool_min_node_count
    node_count             = var.default_node_pool_initial_node_count
    os_disk_type           = var.default_node_pool_os_disk_type
    os_disk_size_gb        = var.default_node_pool_node_disk_size_gb
    tags                   = var.tags
  }



  identity {
    type                      = "UserAssigned"
    user_assigned_identity_id = var.user_assigned_identity_id
  }

  kubelet_identity {
    client_id                 = var.kubelet_identity.client_id
    object_id                 = var.kubelet_identity.object_id # principal_id  =  object_id
    user_assigned_identity_id = var.kubelet_identity.user_assigned_identity_id
  }

  network_profile {
    network_plugin = var.network_plugin
    network_policy = var.network_policy
    outbound_type  = var.outbound_type

  }

  addon_profile {
    oms_agent {
      enabled                    = var.oms_agent.enabled
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }

    azure_policy {
      enabled = var.azure_policy_enabled
    }


    azure_keyvault_secrets_provider {
      enabled                 = var.azure_keyvault_secrets_provider.enabled
      secret_rotation_enabled = var.azure_keyvault_secrets_provider.secret_rotation_enabled

    }

  }

  role_based_access_control {
    enabled = var.role_based_access_control_enabled

    azure_active_directory {
      managed                = var.rbac_ad_managed_enabled
      tenant_id              = var.tenant_id
      admin_group_object_ids = var.admin_group_object_ids
      azure_rbac_enabled     = var.azure_rbac_enabled
    }
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count,
    ]
  }
}

module "aks_diagnostic" {
  source                     = "../diagnostic-settings"
  target_resource_id         = azurerm_kubernetes_cluster.aks_cluster.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  retention_days             = var.log_analytics_retention_days
  name                       = "diag-${var.name}"
}

