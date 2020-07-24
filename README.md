# blai
Repository for Infrastructure as code and  CICD  for Model Deployment &amp; Management

## Dependencies
Terraform CLI - https://www.terraform.io/downloads.html

## Setup Instructions
clone repo.

cd k8s
terraform init
In your initialized directory, run:
terraform apply

review the planned actions. Your terminal output should indicate the plan is running and what resources will be created.

//Have the cluster and the region in the env 
gcloud container clusters get-credentials bladeai-gke-cluster --region europe-west3-a

Deploying kus Dashboard UI:
The Dashboard UI is not deployed by default. To deploy it, run the following command:
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

Now, create a proxy server that will allow you to navigate to the dashboard from the browser on your local machine. This will continue running until you stop the process by pressing
kubectl proxy

Kubectl will make Dashboard available at 
http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/

»Authenticate to Kubernetes Dashboard
To use the Kubernetes dashboard, you need to create a ClusterRoleBinding and provide an authorization token. This gives the cluster-admin permission to access the kubernetes-dashboard. Authenticating using kubeconfig is not an option. You can read more about it in the Kubernetes documentation.

In another terminal (do not close the kubectl proxy process), create the ClusterRoleBinding resource.
kubectl apply -f https://raw.githubusercontent.com/hashicorp/learn-terraform-provision-eks-cluster/master/kubernetes-dashboard-admin.rbac.yaml

Then, generate the authorization token.

Select "Token" on the Dashboard UI then copy and paste the entire token you receive into the dashboard authentication screen to sign in. You are now signed in to the dashboard for your Kubernetes cluster.

kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep service-controller-token | awk '{print $1}')

Select "Token" on the Dashboard UI then copy and paste the entire token you receive into the dashboard authentication screen to sign in. You are now signed in to the dashboard for your Kubernetes cluster.

Check that kubectl is correctly installed and configured by running the kubectl cluster-info command:
kubectl cluster-info
You can also verify the cluster by checking the nodes. Use the following command to list the connected nodes:
kubectl get nodes
To get complete information on each node, run the following:

kubectl describe node

Install helm :
curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get-helm-3 > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh

If you are using OS X you can install it with the brew install command: brew install helm.

Install Seldon Core with Helm

Create namespace:
kubectl create namespace seldon-system

Now we can install Seldon Core in the seldon-system namespace:
helm install seldon-core seldon-core-operator \
    --repo https://storage.googleapis.com/seldon-charts \
    --set usageMetrics.enabled=true \
    --namespace seldon-system \
    --set istio.enabled=true


export NAMESPACE=seldon-system
kubectl create namespace $NAMESPACE

Installing jupyter hub
https://zero-to-jupyterhub.readthedocs.io/en/latest/setup-jupyterhub/setup-jupyterhub.html#setup-jupyterhub

follow the steps:
helm repo add jupyterhub https://jupyterhub.github.io/helm-chart/
helm repo update

RELEASE=jhub
NAMESPACE=jhub

cd helm 
kubectl create namespace $NAMESPACE
helm upgrade --install $RELEASE jupyterhub/jupyterhub \
  --namespace $NAMESPACE  \
  --version=0.9.0 \
  --values config.yaml

You can find the public IP of the JupyterHub by doing:

 kubectl --namespace=jhub get svc proxy-public

