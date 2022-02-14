echo virtualbox-ext-pack virtualbox-ext-pack/license select true | sudo debconf-set-selections
sudo apt install virtualbox virtualbox-ext-pack -y

curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64 \
  && chmod +x minikube
sudo mkdir -p /usr/local/bin/
sudo install minikube /usr/local/bin/

sudo apt-get install -y conntrack

sudo minikube start --vm-driver=none
