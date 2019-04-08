variable "project" {
  default = "aks-kairos-poc"
}

variable "location" {
    default = "westeurope"
}


variable "agent_count" {
    default = 2
}

# refer https://azure.microsoft.com/pricing/details/monitor/ for log analytics pricing 

variable log_analytics_workspace_name {
    default = "LogAnalyticsAksKairosPoc"
}

variable log_analytics_workspace_sku {
    default = "PerGB2018"
}
variable "subscription_id" {
}

variable "client_id" {
}

variable "client_secret" {
}

variable "tenant_id" {
}

variable "virtual_machine_user" {
    default = "azureuser"
}

variable "key_public_path" {
}

variable "virtual_machine_size" {
    #default = "Standard_B1s"
    default = "Standard_DS1_v2"
}
