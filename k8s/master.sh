#!/bin/bash

echo ".....................Update"
apt update && apt full-upgrade

echo ".....................off Swap"
sudo swapoff -a
sudo sed -i '/swap/s/^/#\ /' /etc/fstab

echo ".....................Docker installtion"
apt install docker.io
sudo systemctl start docker
sudo systemctl enable docker
sudo usermod -aG docker ${USER}

echo ".....................Installing kubernetes"
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system
apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update && apt full-upgrade
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

echo "......................swapoff"
sudo swapoff -a

echo ".......................Restart kubelet"
systemctl daemon-reload
systemctl restart kubelet
sudo apt-get update
sudo hostnamectl set-hostname kubernetes-master
sudo kubeadm init --pod-network-cidr=192.168.0.0/16

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

sleep 5m

curl https://projectcalico.docs.tigera.io/manifests/calico.yaml -O
kubectl apply -f calico.yaml

unset KUBECONFIG
export KUBECONFIG=/etc/kubernetes/admin.conf

kubectl get nodes