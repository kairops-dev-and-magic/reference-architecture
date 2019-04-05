provider "azurerm" {
    subscription_id = "${var.subscription_id}"
    client_id       = "${var.client_id}"
    client_secret   = "${var.client_secret}"
    tenant_id       = "${var.tenant_id}"
}

locals {
    env = "${terraform.workspace}"

}

resource "azurerm_resource_group" "aks-kairos-poc" {
  name     = "${var.project}"
  location = "${var.location}"
}

resource "azurerm_log_analytics_workspace" "aks-kairos-poc" {
    name                = "${var.log_analytics_workspace_name}"
    location            = "${var.location}"
    resource_group_name = "${azurerm_resource_group.aks-kairos-poc.name}"
    sku                 = "${var.log_analytics_workspace_sku}"
}

resource "azurerm_log_analytics_solution" "aks-kairos-poc" {
    solution_name         = "ContainerInsights"
    location              = "${azurerm_log_analytics_workspace.aks-kairos-poc.location}"
    resource_group_name   = "${azurerm_resource_group.aks-kairos-poc.name}"
    workspace_resource_id = "${azurerm_log_analytics_workspace.aks-kairos-poc.id}"
    workspace_name        = "${azurerm_log_analytics_workspace.aks-kairos-poc.name}"

    plan {
        publisher = "Microsoft"
        product   = "OMSGallery/ContainerInsights"
    }
}

resource "azurerm_kubernetes_cluster" "aks-kairos-poc" {
    name                = "${var.project}"
    location            = "${azurerm_resource_group.aks-kairos-poc.location}"
    resource_group_name = "${azurerm_resource_group.aks-kairos-poc.name}"
    dns_prefix          = "${var.project}"

    linux_profile {
        admin_username = "${var.virtual_machine_user}"

        ssh_key {
            key_data = "${file("${var.key_public_path}")}"
        }
    }

    agent_pool_profile {
        name            = "agentpool"
        count           = "${var.agent_count}"
        vm_size         = "${var.virtual_machine_size}"
        os_type         = "Linux"
        os_disk_size_gb = 30
    }

    service_principal {
        client_id     = "${var.client_id}"
        client_secret = "${var.client_secret}"
    }

    addon_profile {
        oms_agent {
        enabled                    = true
        log_analytics_workspace_id = "${azurerm_log_analytics_workspace.aks-kairos-poc.id}"
        }
    }

 /* provisioner "local-exec" {
        command = "chmod 700 install-helm.sh && ./install-helm.sh"
  }
*/

    tags {
        Environment = "${local.env}"
    }
}


resource "azurerm_storage_account" "tfstakskairospoc" {
    name                = "tfstakskairospoc"
    resource_group_name = "${azurerm_resource_group.aks-kairos-poc.name}"
    location            = "${var.location}"
    # LRS	ZRS	GRS	RA-GRS 
    account_replication_type = "LRS"
    account_tier = "Standard"

    tags {
        Name = "Terraform Azure storage account tfstakskairospoc"
        Terraform   = "true"
        Environment = "${local.env}"    
    }
}

resource "azurerm_storage_container" "terraform-state-kairos-poc" {
  name                  = "terraform-state-kairos-poc"
  resource_group_name   = "${azurerm_resource_group.aks-kairos-poc.name}"
  storage_account_name  = "${azurerm_storage_account.tfstakskairospoc.name}"
  container_access_type = "private"
}
