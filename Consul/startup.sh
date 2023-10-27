#!/bin/bash

#================================================================================================
# Script Name: startup.sh
# Version : 1.0
# Author: Maarten Verbeeck & Jonas Bossaerts
# Date : 21/04/2022
# Description: TThis script will be used to start all our yaml files for consul
#================================================================================================

############################## Variables ##############################
#Global variables:


############################## Functions ##############################
function CreateAllServices() {
    # Create namespace
    kubectl apply -f ./namespace.yaml
	printf "\n========================================================\n"
    printf " Created the namespace "
    printf "\n========================================================\n"
	
    # Create front-end (deployment & service)
    kubectl apply -f ./front-end.yaml
	printf "\n========================================================\n"
    printf " Created frontend "
    printf "\n========================================================\n"

    # Create carts & carts-db (deployment & service)
    kubectl apply -f ./carts.yaml
	printf "\n========================================================\n"
    printf " Created carts & carts-db "
    printf "\n========================================================\n"
	
    # Create catalogue & catalogue-db (deployment & service)
    kubectl apply -f ./catalogue.yaml
	printf "\n========================================================\n"
    printf " Created catalogue & catalogue-db "
    printf "\n========================================================\n"
	
    # Create orders & orders-db (deployment & service)
    kubectl apply -f ./orders.yaml
	printf "\n========================================================\n"
    printf " Created orders & orders-db "
    printf "\n========================================================\n"
	
    # Create payment (deployment & service)
    kubectl apply -f ./payment.yaml
	printf "\n========================================================\n"
    printf " Created payment "
    printf "\n========================================================\n"
	
    # Create queue-master (deployment & service)
    kubectl apply -f ./queue-master.yaml
	printf "\n========================================================\n"
    printf " Created queue-master "
    printf "\n========================================================\n"
	
    # Create rabbitmq (deployment & service)
    kubectl apply -f ./rabbitmq.yaml
	printf "\n========================================================\n"
    printf " Created rabbitmq "
    printf "\n========================================================\n"
	
    # Create session-db (deployment & service)
    kubectl apply -f ./session-db.yaml
	printf "\n========================================================\n"
    printf " Created session-db "
    printf "\n========================================================\n"
	
    # Create shipping (deployment & service)
    kubectl apply -f ./shipping.yaml
	printf "\n========================================================\n"
    printf " Created shipping "
    printf "\n========================================================\n"
	
    # Create user & user-db (deployment & service)
    kubectl apply -f ./user.yaml
	printf "\n========================================================\n"
    printf " Created user & user-db "
    printf "\n========================================================\n"
	
    # Create intentions rules
   # kubectl apply -f ./intentions-rules.yaml
#	printf "\n========================================================\n"
#    printf " Created intentions-rules "
#    printf "\n========================================================\n"
}

function DeleteAllServices() {
	
    # Delete front-end (deployment & service)
    kubectl delete -f ./front-end.yaml
	printf "\n========================================================\n"
    printf " Deleted frontend "
    printf "\n========================================================\n"

    # Delete carts & carts-db (deployment & service)
    kubectl delete -f ./carts.yaml
	printf "\n========================================================\n"
    printf " Deleted carts & carts-db "
    printf "\n========================================================\n"
	
    # Delete catalogue & catalogue-db (deployment & service)
    kubectl delete -f ./catalogue.yaml
	printf "\n========================================================\n"
    printf " Deleted catalogue & catalogue-db "
    printf "\n========================================================\n"
	
    # Delete orders & orders-db (deployment & service)
    kubectl delete -f ./orders.yaml
	printf "\n========================================================\n"
    printf " Deleted orders & orders-db "
    printf "\n========================================================\n"
	
    # Delete payment (deployment & service)
    kubectl delete -f ./payment.yaml
	printf "\n========================================================\n"
    printf " Deleted payment "
    printf "\n========================================================\n"
	
    # Delete queue-master (deployment & service)
    kubectl delete -f ./queue-master.yaml
	printf "\n========================================================\n"
    printf " Deleted queue-master "
    printf "\n========================================================\n"
	
    # Delete rabbitmq (deployment & service)
    kubectl delete -f ./rabbitmq.yaml
	printf "\n========================================================\n"
    printf " Deleted rabbitmq "
    printf "\n========================================================\n"
	
    # Delete session-db (deployment & service)
    kubectl delete -f ./session-db.yaml
	printf "\n========================================================\n"
    printf " Deleted session-db "
    printf "\n========================================================\n"
	
    # Delete shipping (deployment & service)
    kubectl delete -f ./shipping.yaml
	printf "\n========================================================\n"
    printf " Deleted shipping "
    printf "\n========================================================\n"
	
    # Delete user & user-db (deployment & service)
    kubectl delete -f ./user.yaml
	printf "\n========================================================\n"
    printf " Deleted user & user-db "
    printf "\n========================================================\n"
		
    # Delete intentions rules
    kubectl delete -f ./intentions-rules.yaml
	printf "\n========================================================\n"
    printf " Deleted intentions-rules "
    printf "\n========================================================\n"

    # Delete namespace
    kubectl delete -f ./namespace.yaml
	printf "\n========================================================\n"
    printf " Deleted the namespace "
    printf "\n========================================================\n"
}

function Show_Pods() {
    # Show running pods
    kubectl get pods --namespace sock-shop
}

function Show_Services() {
    # Show running services
    kubectl get services --namespace sock-shop
}

############################## Global Functions ##############################
function Welcome(){
	printf "\n========================================================\n"
	printf "Running startup.sh created by Maarten Verbeeck & Jonas Bossaerts"
	printf "\n========================================================\n"
}

function Help(){
	printf "\n========================================================\n"
	echo " startup.sh create|delete [-h|--help]" 
	echo " "
    echo " This script requires consul installed and kubectl"
    echo " "
	echo " You can use the following commands:"
	echo " create          Create all the Services"
	echo " delete          Delete all the services"
	echo " -h | --help     Show the help"
	printf "\n======================================================== \n"
}

if [ "$1" == "-h" ] || [ "$1" == "--help" ] ; then	#Check if the help parameter is being used
    Help
    exit 0
elif [ "$1" == "delete" ] ; then   #Check if the deletall parameter is being used
    if [ "$2" == "-h" ] || [ "$2" == "--help" ]	; then # When the first parameter is delete and the second parameter is help
		Help
		exit 0
    else
        Welcome
        DeleteAllServices
	    exit 0
    fi
elif [ "$1" == "create" ] ; then	# Check if the first parameter is create
    if [ "$2" == "-h" ] || [ "$2" == "--help" ]	; then # When the first parameter is creatte and the second parameter is help
    	Help
		exit 0
    else
        Welcome
        CreateAllServices
        Show_Pods
        Show_Services
        exit 0
    fi
elif [ -z "$1" ]; then
	#if the option is empty then say it is empty
	printf "please use an option (use -h or --help for more information)"
fi
