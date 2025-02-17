#!/bin/bash

green=`tput setaf 2`
red=`tput setaf 1`
reset=`tput sgr0` 
echo "------------------------------------------------------------------------------------------------------------------------------------"
echo "${green}Configure kubeadm${reset}"
echo "------------------------------------------------------------------------------------------------------------------------------------"
kubeadm config images pull
sleep 1s
echo "------------------------------------------------------------------------------------------------------------------------------------"
echo "${green}Initiating Master with subnet for CNIs 10.244.0.0/16. Can be customized by editing file${reset}"
echo "------------------------------------------------------------------------------------------------------------------------------------"
kubeadm init --pod-network-cidr 10.244.0.0/16
sleep 1s
echo "------------------------------------------------------------------------------------------------------------------------------------"
echo "${red}Remember to copy tokens for adding Worker Nodes${reset}"
echo "------------------------------------------------------------------------------------------------------------------------------------"
echo "${green}Deploying Weave CNI${reset}"
echo "------------------------------------------------------------------------------------------------------------------------------------"
kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
sleep 1s
#echo "------------------------------------------------------------------------------------------------------------------------------------"
#echo "${green}Enable pods to be able to run on Master Node${reset}"
#echo "------------------------------------------------------------------------------------------------------------------------------------"
#kubectl taint nodes --all node-role.kubernetes.io/master-
#sleep 20s
#echo "------------------------------------------------------------------------------------------------------------------------------------"
#echo "${green}checking nodes${reset}"
#echo "------------------------------------------------------------------------------------------------------------------------------------"
#kubectl get nodes -o wide
