This automates deployment of Kubernetes with Master Node and any amount of Worker Nodes on CentOS 8 Upstream.

Scripts are using this guidance with some adjustments for automation purposes:

https://upcloud.com/community/tutorials/install-kubernetes-cluster-centos-8/

These deployment assumes usage of 192.168.250.0/24 subnet, but can be modified. Basically, if you use different subnet, make sure you use IP range from your subnet in step 9.

Follow these steps to deploy Kubernetes:

1. Install Ubuntu 

2. Get this repository by using:

	**git clone https://github.com/ipalvr/kubeinstall**

3. Change directory

	**cd kubeinstall**

4. Make files owned by root and executable

	chmod 777 *

5. Run install_common.sh on Master node and all Worker Nodes. This will prepare your system for Kubernetes implementation

	**sudo ./install_common.sh**

6. **Only on Master Node!** Run configure_master.sh ONLY on Master node. This will configure Kubernetes Master Node with Control Plane and will deploye Calico CNI for Network Management. Please also take a note on command for connectivity from Worker Nodes. Visible above red colored statement "Remember to copy tokens for adding Worker Nodes". You can also modify subnet allocated to pods by Calico CNI. Default subnet is 192.168.50.0/24

	**sudo ./configure_master.sh**

7. **Only on Worker Nodes!** Join all Worker Nodes to Master Node by executing command on Worker Node. Command was visible on Master Node after execution of ./configure_master.sh

	**kubeadm join <MASTER_NODE_IP>:6443 --token <YOUR_TOKEN> \
	--discovery-token-ca-cert-hash sha256: <YOUR_TOKEN_HASH>**

8. **Only on Master Node!** Deploy External LoadBalancer - Metal LB for Bare Metal deployments. Details here: https://metallb.universe.tf/installation/. You can modify External IP Address. Default is 192.168.250.100-192.168.250.110 (they shall be from host subnet).

	**./deploy_metal_lb.sh**

9. **Only if you want to deploy Palo Alto Networks Prisma Cloud Compute and you have valid license for it!** Deploy Prisma Cloud Compute. Execute the following script on your Master Node. You need to have:

     a. Prisma Cloud Comoute License

     b. Prisma Cloud Compute Access Token (provided with License)

     c. Prisma Cloud Compute Software Download Link (Instructions here: https://docs.twistlock.com/docs/releases/release-information/download.html)

	When you have a,b,c availabe, run the following

	**./pcc_deploy.sh**

10. **You will be able to access Prisma Cloud Compute via IP Address mentioned in result of script execution**
