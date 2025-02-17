#!/bin/bash

echo "------------------------------------------------------------------------------------------------------------------------------------"
echo "${green}Configure for regular user${reset}"
echo "------------------------------------------------------------------------------------------------------------------------------------"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
sleep 1s
echo "------------------------------------------------------------------------------------------------------------------------------------"
echo "${green}Enable pods to be able to run on Master Node${reset}"
echo "------------------------------------------------------------------------------------------------------------------------------------"
kubectl taint nodes --all node-role.kubernetes.io/master-
sleep 20s
echo "------------------------------------------------------------------------------------------------------------------------------------"
echo "${green}checking nodes${reset}"
echo "------------------------------------------------------------------------------------------------------------------------------------"
kubectl get nodes -o wide