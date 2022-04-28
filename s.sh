#!/bin/bash

#     Update
apt update && apt full-upgrade
#     Nettools + Git
apt-get install curl apt-transport-https git net-tools ca-certificates gnupg lsb-release
tmux -L dialog-session new-session -d apt -y install iptables-persistent &&  tmux -L dialog-session send-keys Enter &&  tmux -L dialog-session send-keys
#     Docker and compose
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
$(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install docker-ce docker-ce-cli containerd.io

curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2",
  "storage-opts": [
    "overlay2.override_kernel_check=true"
  ]
}
EOF
systemctl restart docker
#     Kuber
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
#modules
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
overlay
EOF
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
overlay
EOF
sudo sh -c "echo 'export KUBECONFIG=/etc/kubernetes/admin.conf' >> /etc/environment"
modprobe br_netfilter
modprobe overlay
swapoff -a
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml


kubectl version --client
docker-compose --version
docker ps

#    groupadd docker
#    sudo usermod -aG docker $USER
#    newgrp docker 
###########################################################
##-----sudo nano /etc/hosts-----
## Add on all machines: 
##     192.168.0.15     k8s-master1.dmosk.local k8s-master1
##     192.168.0.20     k8s-worker1.dmosk.local k8s-worker1
##     192.168.0.25     k8s-worker2.dmosk.local k8s-worker2
###########################################################
##-----sudo nano /etc/fstab----- 
## Comment line with swap 0 1
###########################################################

kubeadm init --pod-network-cidr=10.244.0.0/16
kubectl get nodes



##     PORTS
##-----masternode-----
##     iptables -I INPUT 1 -p tcp --match multiport --dports 6443,2379:2380,10250:10252 -j ACCEPT
##     netfilter-persistent save
##-----worknode-----
##     iptables -I INPUT 1 -p tcp --match multiport --dports 10250,30000:32767 -j ACCEPT
##     netfilter-persistent save

##     https://www.dmosk.ru/instruktions.php?object=kubernetes-ubuntu

##     yes | sudo bash s.sh
