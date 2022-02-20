#swap off
sudo swapoff -a

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

sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker

sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
# Add a GPG key for the Packages
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
# Install kubelet, kubeadm, kubectl
sudo apt-get install -y kubelet kubeadm kubectl
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
  podSubnet: 192.168.0.0/16 #<-- Match the IP range from the Calico config file
EOF
# kubeadm init
kubeadm init --config=$HOME/kubeadm-config.yaml --upload-certs | tee kubeadm-init.out
exit
# mkdir -p $HOME/.kube
# sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
# sudo chown $(id -u):$(id -g) $HOME/.kube/config

# auto completion
sudo apt-get install bash-completion -y
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> $HOME/.bashrc
echo "alias k=kubectl" >> $HOME/.bashrc
echo "complete -F __start_kubectl k" >> $HOME/.bashrc


