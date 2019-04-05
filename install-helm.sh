#!/bin/bash
        
HELM_SCRIPT_URL='https://raw.githubusercontent.com/helm/helm/master/scripts/get'
HELM_SCRIPT_FILENAME='get_helm.sh'
KUBE_CONFIG_FILENAME='kube_config-azure-aks-kairos-poc'

echo "Loading Kubeconfig"

echo "$(terraform output kube_config)" > /$KUBE_CONFIG_FILENAME

export KUBECONFIG=./$KUBE_CONFIG_FILENAME

kubectl get nodes  && echo "Kubeconfig Working Correctly"

curl $HELM_SCRIPT_URL > $HELM_SCRIPT_FILENAME

chmod 700 $HELM_SCRIPT_FILENAME

./$HELM_SCRIPT_FILENAME

rm $HELM_SCRIPT_FILENAME

 Helm init  && echo "Helm installed Correctly"

 
     