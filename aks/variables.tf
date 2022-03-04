######################## Initial Values ################################
variable "name" {
  description = "(Required) Specifies the name of the AKS cluster."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the location where the AKS cluster will be deployed."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) Specifies the name of the resource group."
  type        = string
}

variable "kubernetes_version" {
  description = "Specifies the AKS Kubernetes version"
  default     = "1.22.4"
  type        = string
}




variable "dns_prefix_managed_cluster" {
  description = "(Optional) Private cluster DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created."
  type        = string
}


variable "private_cluster_enabled" {
  description = "Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created."
  type        = bool
  default     = false
}

variable "local_account_disabled" {
  description = "local_account_disabled"
  type        = bool
  default     = true
}


variable "sku_tier" {
  description = "(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free."
  default     = "Free"
  type        = string

  validation {
    condition     = contains(["Free", "Paid"], var.sku_tier)
    error_message = "The sku tier is invalid."
  }
}


variable "aks_api_server_authorized_ip_ranges" {
  type        = list(string)
  default     = []
  description = "The IP ranges to whitelist for incoming traffic to the masters."
}
################################################################################


#####  default_node_pool #####

variable "default_node_pool_name" {
  description = "Specifies the name of the default node pool"
  default     = "system"
  type        = string
}

variable "default_node_pool_type" {
  description = "Specifies the type  of the default node pool"
  default     = "system"
  type        = string
}

variable "default_node_pool_vm_size" {
  description = "Specifies the vm size of the default node pool"
  default     = "Standard_F8s_v2"
  type        = string
}



variable "default_node_pool_nodes_subnet_id" {
  description = "Specifies the id of the subnet that hosts the default node pool"
  type        = string
}



variable "default_node_pool_availability_zones" {
  description = "Specifies the availability zones of the default node pool"
  default     = ["1", "2", "3"]
  type        = list(string)
}

variable "default_node_pool_node_labels" {
  description = "(Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created."
  type        = map(any)
  default     = {}
}


variable "default_node_pool_enable_auto_scaling" {
  description = "(Optional) Whether to enable auto-scaler. Defaults to false."
  type        = bool
  default     = true
}

variable "default_node_pool_enable_host_encryption" {
  description = "(Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to false."
  type        = bool
  default     = false
}


variable "default_node_pool_max_pods" {
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
  type        = number
  default     = 50
}

variable "default_node_pool_max_node_count" {
  description = "(Required) The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to min_count."
  type        = number
  default     = 12
}

variable "default_node_pool_min_node_count" {
  description = "(Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to max_count."
  type        = number
  default     = 3
}

variable "default_node_pool_initial_node_count" {
  description = "(Optional) The initial number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be a value in the range min_count - max_count."
  type        = number
  default     = 4
}


variable "default_node_pool_os_disk_type" {
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created."
  type        = string
  default     = "Ephemeral"
}

variable "default_node_pool_node_disk_size_gb" {
  description = "(Optional) The Agent Operating System disk size in GB. Changing this forces a new resource to be created."
  type        = number
  default     = null
}

variable "tags" {
  type = map(string)

  default = {
    project = "default"
  }
}


################################################################################



variable "user_assigned_identity_id" {
  description = "id of the  identity of the AKS cluster."
  type        = string
  default     = "Ephemeral"
}


variable "kubelet_identity" {
  description = "id of the kubelet identity of the AKS cluster."
  type        = map(any)
  default     = {}
}


####################### Network Profile  ##################################

variable "network_plugin" {
  description = "Specifies the network plugin of the AKS cluster"
  default     = "azure"
  type        = string
}

variable "network_policy" {
  description = "Specifies the network policy of the AKS cluster"
  default     = "azure"
  type        = string
}



variable "outbound_type" {
  description = "(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting. Defaults to loadBalancer."
  type        = string
  default     = "userDefinedRouting"

  validation {
    condition     = contains(["loadBalancer", "userDefinedRouting"], var.outbound_type)
    error_message = "The outbound type is invalid."
  }
}

####################################################################

###############  Addon Profile ########################


variable "oms_agent" {
  description = "Specifies the OMS agent addon configuration."
  type = object({
    enabled = bool
  })

}

variable "azure_policy_enabled" {
  description = "Specifies the Azure Policy addon configuration."
  type        = string
  default     = true

}

#Kubernetes Dashboard addon is deprecated for Kubernetes version >= 1.19.0

# variable "kube_dashboard_enabled" {
#   description = "Specifies the Kubernetes Dashboard addon configuration."
#   type        = string
#   default     = true

# }


variable "azure_keyvault_secrets_provider" {
  description = "Azure keyvault secret provider settings"
  type = object({
    enabled                 = bool
    secret_rotation_enabled = bool
  })
}


####################################################################


#################  RBAC   #################################
variable "role_based_access_control_enabled" {
  description = "(Required) Is Role Based Access Control Enabled? Changing this forces a new resource to be created."
  default     = true
  type        = bool
}



variable "tenant_id" {
  description = "(Required) The tenant id of the system assigned identity which is used by master components."
  type        = string
}


variable "admin_group_object_ids" {
  description = "(Optional) A list of Object IDs of Azure Active Directory Groups which should have Admin Role on the Cluster."
  default     = []
  type        = list(string)
}



variable "azure_rbac_enabled" {
  description = "(Optional) Is Role Based Access Control based on Azure AD enabled?"
  default     = true
  type        = bool
}


variable "rbac_ad_managed_enabled" {
  description = " (Optional) Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration."
  default     = true
  type        = bool
}

##################################################################


#################################  AKS Logging   #################################

variable "log_analytics_workspace_id" {
  description = "(Optional) The ID of the Log Analytics Workspace which the OMS Agent should send data to. Must be present if enabled is true."
  type        = string
}



variable "log_analytics_retention_days" {
  description = "Specifies the number of days of the retention policy"
  type        = number
  default     = 30
}


