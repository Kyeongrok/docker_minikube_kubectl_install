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
