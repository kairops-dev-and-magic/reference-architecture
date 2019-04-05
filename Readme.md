
# Azure Kubernetes Service AKS installation using Terraform

This execution was tested over Ubuntu 16.04 host with the next binaries installed:

Kubectl
curl

# Use Terraform  for create AKS + Helm

Execute Terraform

$terraform apply


# Get Credentials configuration for allow to Terraform use Azure Api  ( Pre Steps )

This Step is by  environment ( Is recommended use separated subscription for each environment )

Azure CLI

Copiar

Pruébelo
az account show --query "{subscriptionId:id, tenantId:tenantId}"
Para utilizar una suscripción seleccionada, defina la suscripción para esta sesión con az account set. Establezca la variable de entorno SUBSCRIPTION_ID para almacenar el valor devuelto del campo id de la suscripción que quiere usar:
Azure CLI

Copiar

Pruébelo
az account set --subscription="${SUBSCRIPTION_ID}"
Ahora puede crear una entidad de servicio para su uso con Terraform. Utilice[az ad sp create-for-rbac]/cli/azure/ad/sp#az-ad-sp-create-for-rbac) y defina el ámbito de la suscripción como se indica a continuación:
Azure CLI

Copiar

Pruébelo
az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"


{
  "subscriptionId": "changeme",
  "tenantId": "changeme"
}


{
  "appId": "changeme",
  "displayName": "changeme",
  "name": "changeme",
  "password": "changeme",
  "tenant": "changeme"
}    

# Change  values in terraform.tfvars   ( Pre Steps )

subscription_id = "changeme"

client_id = "changeme"

client_secret = "changeme"

tenant_id = "changeme"



# Kubectl configuration  ( Use  install-helm.sh )

In this part exist  the needed of root credentials for allow install Helm in local.

Obtenga la configuración de Kubernetes desde el estado de Terraform y almacénela en un archivo que kubectl puede leer.
bash

Copiar
echo "$(terraform output kube_config)" > ./kube_config-azure-aks-kairos-poc
Establezca una variable de entorno para que kubectl seleccione la configuración correcta.
bash

Copiar
export KUBECONFIG=./kube_config-azure-aks-kairos-poc

# Init backed config over azure

In terraform.tf uncomment lines and file must be edited the acces_key from storage account tfstakskairospoc created  ( one for environment )

$terraform init  

