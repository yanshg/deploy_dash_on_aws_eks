# deploy_dash_on_aws_eks
deploy dash app on AWS EKS with Terraform and Helm Charts


# Setup development environment

# Make sure git working or create docker image

# Install awscli/helm/terraform
# Update the script to get latest version like:
# Terraform: https://releases.hashicorp.com/terraform/
./install_helm_terraform.sh

# Ger Access Key and Secret Key from AWS Console
# upper right "<your name>" -> "My Security Credentials"


# Configure with Access Key and Secret Key (under ~/.aws)
aws configure



# Get project sources
mkdir -r project
cd project

# Generate key pair with AWSCLI or on
aws ec2 create-key-pair --key-name my-key-pair --query "KeyMaterial" --output text > ./id_rsa_aws
chmod 400 ./id_rsa_aws

aws ec2 describe-key-pairs

# Generate public key from the key pair
ssh-keygen -y -f ./id_rsa_aws > ./id_rsa_aws.pub





# Download latest deployment codes on github.com
git clone https://github.com/hashicorp/learn-terraform-provision-eks-cluster.git




# Deploy Kubenetes cluster on AWS
cd learn-terraform-provision-eks-cluster

terraform init

# If any certificate issue, run 'pip3 install -U  certifi')
https://stackoverflow.com/questions/63557500/botocore-exceptions-sslerror-ssl-validation-failed-on-windows
https://hynek.me/articles/apple-openssl-verification-surprises/

terraform plan

terraform apply

## Show what AWS resources were deployed
terraform show

## Show output information
terraform output



# Configure kubectl
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name) --no-verify-ssl

kubectl config view

# Provision Kubenetes metrics-server onto the EKS cluster

# Follow tuitial
https://docs.aws.amazon.com/eks/latest/userguide/dashboard-tutorial.html
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.3.7/components.yaml

# Or manually
wget -O v0.3.6.tar.gz https://codeload.github.com/kubernetes-sigs/metrics-server/tar.gz/v0.3.6 --no-check-certificate && tar xzvf v0.3.6.tar.gz

kubectl apply -f metrics-server-0.3.6/deploy/1.8+/

kubectl get deployment metrics-server -n kube-system

# Deploy Kubenetes Dashboard
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.5/aio/deploy/recommended.yaml

# Start proxy server
kubectl proxy


# Helm
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm upgrade --install dash bitnami/nginx --set image.repository="jerowe/dash-sample-app-dash-cytoscape-lda" --set image.tag="1.0"  --set containerPort=8050

kubectl get svc --namespace default -w dash-nginx

aws eks get-token --cluster-name $(terraform output -raw cluster_name)
kubectl describe configmap -n kube-system aws-auth

