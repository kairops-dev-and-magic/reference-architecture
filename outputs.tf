output "client_key" {
    value = "${azurerm_kubernetes_cluster.aks-kairos-poc.kube_config.0.client_key}"
}

output "client_certificate" {
    value = "${azurerm_kubernetes_cluster.aks-kairos-poc.kube_config.0.client_certificate}"
}

output "cluster_ca_certificate" {
    value = "${azurerm_kubernetes_cluster.aks-kairos-poc.kube_config.0.cluster_ca_certificate}"
}

output "cluster_username" {
    value = "${azurerm_kubernetes_cluster.aks-kairos-poc.kube_config.0.username}"
}

output "cluster_password" {
    value = "${azurerm_kubernetes_cluster.aks-kairos-poc.kube_config.0.password}"
}

output "kube_config" {
    value = "${azurerm_kubernetes_cluster.aks-kairos-poc.kube_config_raw}"
}

output "host" {
    value = "${azurerm_kubernetes_cluster.aks-kairos-poc.kube_config.0.host}"
}

output "azurerm_storage_account_access_key_tfstakskairospoc" {
    value = [ "${azurerm_storage_account.tfstakskairospoc.*.primary_access_key}" ]
}
