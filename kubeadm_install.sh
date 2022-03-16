
K8S_VERSION="1.21.1-00"
POD_SUBNET="10.244.0.0/16"
HOST_NAME="controlplane"

#swap off
sudo swapoff -a

# hostname to 'controlplane'
hostnamectl set-hostname $HOST_NAME

sudo mkdir /etc/docker
cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

# Install Docker
sudo apt-get update
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker

# check cgroup driver
docker info | grep -i cgroup

sudo apt-get install -y apt-transport-https ca-certificates curl
# Add a GPG key for the Packages
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
# Install kubelet, kubeadm, kubectl
sudo apt-get install -y kubeadm=$K8S_VERSION kubelet=$K8S_VERSION kubectl=$K8S_VERSION
sudo apt-mark hold kubelet kubeadm kubectl

# add <host_ip> controlplane to /etc/hosts
sudo echo $(hostname -I | awk '{ print $1 }') controlplane >> /etc/hosts

# create kubeadm-config.yaml
cat <<EOF > $HOME/kubeadm-config.yaml
apiVersion: kubeadm.k8s.io/v1beta2
kind: ClusterConfiguration
kubernetesVersion: $(kubelet --version |  awk '{ print $2 }')
controlPlaneEndpoint: "controlplane:6443" #<-- Use the node alias not the IP
networking:  #<-- Use the word stable for newest version
  podSubnet: $POD_SUBNET #<-- Match the IP range from the Calico config file
---
kind: KubeletConfiguration
apiVersion: kubelet.config.k8s.io/v1beta1
cgroupDriver: systemd
EOF
# kubeadm init
echo $HOME
kubeadm init --config=$HOME/kubeadm-config.yaml --upload-certs | tee kubeadm-init.out

#su - ubuntu
#mkdir -p $HOME/.kube
#sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#sudo chown $(id -u):$(id -g) $HOME/.kube/config

# auto completion
sudo apt-get install bash-completion -y
#source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> $HOME/.bashrc
echo "alias k=kubectl" >> $HOME/.bashrc
echo "complete -F __start_kubectl k" >> $HOME/.bashrc


