#!/bin/bash

#================================================================================================
# Script Name: AWS-Startup.sh
# Version : 1.0
# Author: Maarten Verbeeck & Jonas Bossaerts
# Date : 25/05/2022
# Description: This script will be used to startup our environment on AWS
#================================================================================================

############################## Variables ##############################
# Global variables:
AWS_Access_Key_ID="***"
AWS_Secret_Access_Key="***"
Default_region="eu-west-3"
GRN=$'\e[1;32m'
RED=$'\e[1;31m'
BLUE=$'\e[1;34m'
ENDCOL=$'\e[0m'
StartTime=0
EndTime=0
TotalTime=0

############################## Checking software ##############################

function checkInstallation(){
# Check if curl is installed
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Checking if curl is installed, if not it will be installed" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    sleep 1
    if which curl ; then
        printf "%s\n========================================================\n" "$GRN"
        printf "%s curl is installed on the machine" "$GRN"
        printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
        sleep 1
    else 
        printf "%s \n========================================================\n" "$RED"
        printf "%s curl is not installed on the machine and will be installed now" "$RED"
        printf "%s \n========================================================\n %s" "$RED" "$ENDCOL"
        apt-get install curl -y
        printf "%s \n========================================================\n" "$GRN"
        printf "%s curl is now succesfully installed on the machine" "$GRN"
        printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
        sleep 1
    fi

# Check if Helm is installed
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Checking if Helm is installed, if not it will be installed" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    sleep 1
    if which helm ; then
        printf "%s\n========================================================\n" "$GRN"
        printf "%s Helm is installed on the machine" "$GRN"
        printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
        sleep 1
    else 
        printf "%s \n========================================================\n" "$RED"
        printf "%s Helm is not installed on the machine and will be installed now" "$RED"
        printf "%s \n========================================================\n %s" "$RED" "$ENDCOL"
        curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
        chmod 700 get_helm.sh
        ./get_helm.sh
        printf "%s \n========================================================\n" "$GRN"
        printf "%s Helm is now succesfully installed on the machine" "$GRN"
        printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
        sleep 1
    fi

# Check if terraform is installed
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Checking if Terraform is installed, if not it will be installed" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    sleep 1
    if which terraform ; then
        printf "%s\n========================================================\n" "$GRN"
        printf "%s Terraform is installed on the machine" "$GRN"
        printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
        sleep 1
    else 
        printf "%s \n========================================================\n" "$RED"
        printf "%s Terraform is not installed on the machine and will be installed now" "$RED"
        printf "%s \n========================================================\n %s" "$RED" "$ENDCOL"
        apt-get update -y && apt-get install -y gnupg software-properties-common curl -y
        curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
        apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" -y
        apt-get update -y && apt-get install terraform -y
        printf "%s \n========================================================\n" "$GRN"
        printf "%s Terraform is now succesfully installed on the machine" "$GRN"
        printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
        sleep 1
    fi

# Check if unzip is installed
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Checking if unzip is installed, if not it will be installed" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    sleep 1
    if which unzip ; then
        printf "%s\n========================================================\n" "$GRN"
        printf "%s Unzip is installed on the machine" "$GRN"
        printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
        sleep 1
    else 
        printf "%s \n========================================================\n" "$RED"
        printf "%s Unzip is not installed on the machine and will be installed now" "$RED"
        printf "%s \n========================================================\n %s" "$RED" "$ENDCOL"
        apt install unzip
        printf "%s \n========================================================\n" "$GRN"
        printf "%s Unzip is now succesfully installed on the machine" "$GRN"
        printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
        sleep 1
    fi

# Check if aws cli is installed
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Checking if AWS CLI is installed, if not it will be installed" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    sleep 1
    if which aws ; then
        printf "%s\n========================================================\n" "$GRN"
        printf "%s AWS CLI is installed on the machine" "$GRN"
        printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
        sleep 1
    else 
        printf "%s \n========================================================\n" "$RED"
        printf "%s AWS CLI is not installed on the machine and will be installed now" "$RED"
        printf "%s \n========================================================\n %s" "$RED" "$ENDCOL"
        curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
        unzip awscliv2.zip
        ./aws/install --update
        printf "%s \n========================================================\n" "$GRN"
        printf "%s AWS CLI is now succesfully installed on the machine" "$GRN"
        printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
        sleep 1
    fi

# Check if kubectl is installed
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Checking if Kubectl is installed, if not it will be installed" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    sleep 1
    if which kubectl ; then
        printf "%s\n========================================================\n" "$GRN"
        printf "%s Kubectl is installed on the machine" "$GRN"
        printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
        sleep 1
    else 
        printf "%s \n========================================================\n" "$RED"
        printf "%s Kubectl is not installed on the machine and will be installed now" "$RED"
        printf "%s \n========================================================\n %s" "$RED" "$ENDCOL"
        curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
        install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
        printf "%s \n========================================================\n" "$GRN"
        printf "%s Kubectl is now succesfully installed on the machine" "$GRN"
        printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
        sleep 1
    fi
}
############################## Installing ##############################

# Starting Terraform on AWS
function TerraformAWS() {
    cd Terraform/AWS/
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Starting up Terraform init" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    sleep 1
    terraform init 
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Applying Terraform" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    terraform apply -auto-approve
    printf "%s \n========================================================\n" "$GRN"
    printf "%s Terraform succesfully configured EKS on AWS" "$GRN"
    printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
    sleep 1
    cd ../..
}

# Connecting to the AWS cluster
function AWSConfigure(){
    sleep 1
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Starting the connection to the AWS platform" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    sleep 1
    aws configure set aws_access_key_id $AWS_Access_Key_ID
    aws configure set aws_secret_access_key $AWS_Secret_Access_Key
    aws configure set default.region $Default_region
    printf "%s \n========================================================\n" "$GRN"
    printf "%s Succesfully connected to AWS" "$GRN"
    printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
    sleep 1
}

# Changing Test2-Helm.yaml
function ChangeTest2-Helm(){
    cd ..
    cd Terraform/AWS/
    cluster_endpoint=$(terraform output -raw cluster_endpoint)
    cd ../..
    cd Consul/
    cat << EOF > Test2-Helm.yaml
global:
  name: consul
  datacenter: dc2
  tls:
    enabled: true

    # Here we're using the shared certificate authority from the primary
    # datacenter that was exported via the federation secret.
    caCert:
      secretName: consul-federation
      secretKey: caCert
    caKey:
      secretName: consul-federation
      secretKey: caKey

  acls:
    manageSystemACLs: false

    # Here we're importing the replication token that was
    # exported from the primary via the federation secret.
    #  replicationToken:
     # secretName: consul-federation
     # secretKey: replicationToken

  federation:
    enabled: true
    k8sAuthMethodHost: $cluster_endpoint
    primaryDatacenter: dc1
  name: consul
 # gossipEncryption:
  #  secretName: consul-federation
   # secretKey: gossipEncryptionKey
connectInject:
  enabled: true
meshGateway:
  enabled: true
controller:
  enabled: true
server:
  # Here we're including the server config exported from the primary
  # via the federation secret. This config includes the addresses of
  # the primary datacenter's mesh gateways so Consul can begin federation.
  extraVolumes:
    - type: secret
      name: consul-federation
      items:
        - key: serverConfigJSON
          path: config.json
      load: true
EOF
}

# Installing consul on the cluster
function InstallAWSConsul(){
    cd Consul/
    chmod 600 ~/.kube/config
    aws eks update-kubeconfig --region eu-west-3 --name consul-eks
    sleep 1
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Starting to install consul on the cluster" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    sleep 1
    helm repo add hashicorp https://helm.releases.hashicorp.com
    helm install --values Test-Helm.yaml consul hashicorp/consul --create-namespace --namespace consul
    printf "%s \n========================================================\n" "$GRN"
    printf "%s Succesfully installed consul on the cluster" "$GRN"
    printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
    sleep 1
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Starting to create the federation key for the second consul datacenter" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    kubectl get secret -n consul consul-federation --output yaml > consul-federation-secret.yaml
    printf "%s \n========================================================\n" "$GRN"
    printf "%s Succesfully created the federation key for the second datacenter" "$GRN"
    printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
    sleep 1
    ChangeTest2-Helm
    sleep 1

    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Starting to install Prometheus & Grafana on the cluster" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
    helm repo add stable https://charts.helm.sh/stable
    helm repo add grafana https://grafana.github.io/helm-charts
    helm install -f Static/prometheus-values.yaml prometheus prometheus-community/prometheus
    helm install -f Static/grafana-values.yaml grafana grafana/grafana
    sleep 1
    printf "%s \n========================================================\n" "$GRN"
    printf "%s Succesfully installed Prometheus & Grafana on the cluster" "$GRN"
    printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
    cd ..
}

# Installing the static application on the AWS cluster
function InstallStaticYaml(){
    cd Consul/Static/
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Starting to install yaml files on datacenter 1" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    kubectl apply -f ../proxydefaults.yaml
    kubectl apply -f ./static-client.yaml
    kubectl get pods
    printf "%s \n========================================================\n" "$GRN"
    printf "%s Succesfully installed yaml files on datacenter 1" "$GRN"
    printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
    cd ../..
}

# Installing the hashicups application on the AWS cluster
function InstallCupsYaml(){
    cd Consul/hashicups/
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Starting to install yaml files on datacenter 1" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    kubectl apply -f ../proxydefaults.yaml
    kubectl apply -f ./frontend.yaml
    printf "%s \n========================================================\n" "$GRN"
    printf "%s Succesfully installed yaml files on datacenter 1" "$GRN"
    printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
    cd ../..
}

# Exposing the Consul UI 
function ExposeConsolUI(){
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Exposing the consol UI to localhost:5000" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    kubectl --namespace consul port-forward service/consul-ui 5000:443 --address 0.0.0.0
}
# Exposing the Grafana UI
function ExposeGrafanaUI(){
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Exposing the grafana to localhost:3000, you can login here with user:admin & password:password" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    kubectl port-forward svc/grafana 3000:3000 --address 0.0.0.0
}

############################## Deleting ##############################

# Deleting the cluster on AWS with Terraform
function DeleteTerraformAWS(){
    cd Terraform/AWS/
    sleep 1
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Starting deletion cluster with Terraform" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    sleep 1
    terraform destroy -auto-approve
    printf "%s \n========================================================\n" "$GRN"
    printf "%s Terraform succesfully deleted the EKS cluster on AWS" "$GRN"
    printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
    cd ../../
}


# Deleting consul from the AWS cluster
function DeleteConsul(){
    cd Consul/
    sleep 1
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Starting to uninstall consul of the cluster" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    helm uninstall consul --namespace consul
    printf "%s \n========================================================\n" "$GRN"
    printf "%s Succesfully uninstalled consul of the cluster" "$GRN"
    printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
    
    sleep 1
    
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Starting to uninstall Prometheus & Grafana of the cluster" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    helm uninstall prometheus 
    helm uninstall grafana 
    sleep 1
    printf "%s \n========================================================\n" "$GRN"
    printf "%s Succesfully uninstalled Prometheus & Grafana of the cluster" "$GRN"
    printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
    cd ..
}

# Deleting the Static application from AWS
function deleteYamlStatic() {
    cd Consul/Static/
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Starting to uninstall yaml files on datacenter 1" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    kubectl delete -f ./static-client.yaml
    printf "%s \n========================================================\n" "$GRN"
    printf "%s Succesfully uninstalled yaml files on datacenter 1" "$GRN"
    printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
    cd ../..
}

# Deleting the hashicup application from AWS
function deleteYamlHashicups() {
    cd Consul/hashicups/
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Starting to uninstall yaml files on datacenter 1" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
    kubectl delete -f ./frontend.yaml
    printf "%s \n========================================================\n" "$GRN"
    printf "%s Succesfully uninstalled yaml files on datacenter 1" "$GRN"
    printf "%s \n========================================================\n %s" "$GRN" "$ENDCOL"
    cd ../..
}

############################## Global Functions ##############################

# Welcome function
function Welcome(){
    printf "%s\n========================================================\n" "$BLUE"
    printf "%s Running AWS-Startup.sh created by Maarten Verbeeck & Jonas Bossaerts" "$BLUE"
    printf "%s\n========================================================\n %s" "$BLUE" "$ENDCOL"
}

function Help(){
	printf "\n========================================================\n"
	echo " sudo AWS-Startup.sh deploy|delete [-h|--help]" 
    echo " MAKE SURE TO USE SUDO!"
    echo " "
	echo " You can use the following commands:"
	echo " deploy all           Startups Terraform and creates everything on the cluster"
	echo " deploy terraform     Startups Terraform"
	echo " deploy static        Deploys the static demo application on the cluster"
    echo " deploy hashicups     Deploys the hashicups demo application on the cluster"
	echo " deploy consul        Deploys consul on the cluster (with Prometheus & Grafana)"
    echo " =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
	echo " delete all           The entire cluster on AWS"
	echo " delete terraform     Destroys Terraform"
	echo " delete static        Deletes the static demo application on the cluster"
	echo " delete hashicups     Deletes the hashicups demo application on the cluster"
	echo " delete consul        Deletes consul of the cluster (with Prometheus & Grafana)"
    echo " =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-"
    echo " expose consol        This exposes the Consol UI to https://localhost:5000"
    echo " expose grafana       This exposes the Grafana UI to http://localhost:3000"
    echo " "
	echo " -h | --help          Show the help"
	printf "\n======================================================== \n"
}

############################## IF statement ##############################

if [ "$1" == "-h" ] || [ "$1" == "--help" ] ; then	#Check if the help parameter is being used
    Help
    exit 0
elif [[ $(/usr/bin/id -u) -ne 0 ]] ; then
    printf "%s \n Not running as root, make sure to run this script as sudo AWS-Startup.sh deploy|delete [-h|--help] \n %s" "$RED" "$ENDCOL"
    exit
elif [ "$1" == "delete" ] ; then   #Check if delete parameter is being used
    if [ "$2" == "-h" ] || [ "$2" == "--help" ]	; then # When the first parameter is delete and the second parameter is help
		Help
		exit 0
    elif [ "$2" == "all" ] ; then # When the entire cluster has to be deleted
        Welcome
        DeleteTerraformAWS
	    exit 0
    elif [ "$2" == "terraform" ] ; then # When the terraform destroy has been requested
        Welcome
        DeleteTerraformAWS
	    exit 0
    elif [ "$2" == "static" ] ; then # When the static application has to be deleted
        Welcome
        deleteYamlStatic
	    exit 0
    elif [ "$2" == "hashicups" ] ; then # When the hashicups application has to be deleted
        Welcome
        deleteYamlHashicups
	    exit 0
    elif [ "$2" == "consul" ] ; then # When consul has to be deleted
        Welcome
        DeleteConsul
	    exit 0
    fi
elif [ "$1" == "deploy" ] ; then	# Check if the first parameter is deploy
    if [ "$2" == "-h" ] || [ "$2" == "--help" ]	; then # When the first parameter is deploy and the second parameter is help
    	Help
		exit 0
    elif [ "$2" == "all" ] ; then # When the project has to be created
        Welcome
        checkInstallation
        AWSConfigure
        TerraformAWS
        InstallAWSConsul
        InstallCupsYaml
        InstallStaticYaml
	    exit 0
    elif [ "$2" == "terraform" ] ; then # Creating Terraform
        Welcome
        checkInstallation
        AWSConfigure
        TerraformAWS
	    exit 0
    elif [ "$2" == "static" ] ; then # Deploying the static application
        Welcome
        AWSConfigure
        checkInstallation
        InstallStaticYaml
	    exit 0
    elif [ "$2" == "hashicups" ] ; then # Deploying the hashicups application
        Welcome
        AWSConfigure
        checkInstallation
        InstallCupsYaml
	    exit 0
    elif [ "$2" == "consul" ] ; then # Configuring consul on the cluster
        Welcome
        AWSConfigure
        checkInstallation
        InstallAWSConsul
	    exit 0
    fi
elif [ "$1" == "expose" ] ; then	# Check if the first parameter is expose
    if [ "$2" == "-h" ] || [ "$2" == "--help" ]	; then # When the first parameter is expose and the second parameter is help
    	Help
		exit 0
    elif [ "$2" == "consul" ] ; then # When we want to expose consol UI
        Welcome
        AWSConfigure
        ExposeConsolUI
	    exit 0
    elif [ "$2" == "grafana" ] ; then # When we want to expose Grafana UI
        Welcome
        AWSConfigure
        ExposeGrafanaUI
	    exit 0
    fi
elif [ -z "$1" ]; then
	#if the option is empty then say it is empty
	printf "%s \n please use an option (use -h or --help for more information)\n %s" "$RED" "$ENDCOL"
fi
