#swap off
sudo swapoff -a

# hostname to 'node01'
hostnamectl set-hostname 'node01'


# Install Docker
sudo apt-get install -y docker.io
sudo systemctl enable docker
sudo systemctl daemon-reload
sudo systemctl restart docker

echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
# Add a GPG key for the Packages
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
sudo apt-get update
# Install kubelet, kubeadm, kubectl
sudo apt-get install -y kubeadm=1.21.1-00 kubelet=1.21.1-00 kubectl=1.21.1-00
sudo apt-mark hold kubelet kubeadm kubectl

