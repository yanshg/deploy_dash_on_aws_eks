#!/bin/bash

mkdir -p /usr/local/bin

# Install clis needed for kubernetes + eks
curl -k -o awscliv2.zip \
        https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
unzip awscliv2.zip
./aws/install
rm -rf aws awscliv2.zip

curl -k -o aws-iam-authenticator \
        https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/aws-iam-authenticator
chmod +x ./aws-iam-authenticator

mv ./aws-iam-authenticator /usr/local/bin/

curl -k -o kubectl \
        https://amazon-eks.s3.us-west-2.amazonaws.com/1.18.9/2020-11-02/bin/linux/amd64/kubectl

chmod +x ./kubectl
mv ./kubectl /usr/local/bin/kubectl

curl -k -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
chmod 700 get_helm.sh
sed -i 's/curl /curl -k /g' get_helm.sh
./get_helm.sh
rm ./get_helm.sh

# Get terraform
wget --no-check-certificate https://releases.hashicorp.com/terraform/0.14.5/terraform_0.14.5_linux_amd64.zip
unzip terraform_0.14.5_linux_amd64.zip
mv terraform /usr/local/bin
rm terraform_0.14.5_linux_amd64.zip

