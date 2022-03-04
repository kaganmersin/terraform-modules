variable "target_resource_id" {
  type = string
}

variable "log_analytics_workspace_id" {
  type = string
}


variable "name" {
  type = string
}


variable "retention_days" {
  type = number
  validation {
    condition     = var.retention_days >= 60
    error_message = "The retention_days value must be a equal to 60, or higher than 60."

  }
}