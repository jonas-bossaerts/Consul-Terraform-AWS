#!/bin/bash

#================================================================================================
# Script Name: Demo-Script.sh
# Version : 1.0
# Author: Maarten Verbeeck & Jonas Bossaerts
# Date : 10/06/2022
# Description: This script will be used to configure our environment on AWS
#================================================================================================

# Switching to AWS context
function SwitchContext(){
  kubectl config use-context arn:aws:eks:eu-west-3:477260611181:cluster/consul-eks
}

# Exposing the frontend of hashicups
function ExposeFrontend(){
  kubectl port-forward service/frontend 18080:80
}

# Retrieving Text from static server
function RetrieveStaticServer(){
  kubectl exec deploy/static-client -c static-client -- curl -sS http://localhost:8080
}

############################## IF statement ##############################

if [[ $(/usr/bin/id -u) -ne 0 ]] ; then
    printf "%s Not running as root, make sure to run this script as sudo Demo-Script.sh frontend|static \n %s" "$RED" "$ENDCOL"
    exit
elif [ "$1" == "frontend" ] ; then   # Exposing frontend hashicups
    SwitchContext
    ExposeFrontend
    exit
elif [ "$1" == "static" ] ; then   # Retrieving static info
    SwitchContext
    RetrieveStaticServer
    exit
fi