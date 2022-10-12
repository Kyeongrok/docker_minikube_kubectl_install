### Minikube설치 한번에

<img src="https://img.shields.io/badge/kubernetes-brightgreen?logo=Kubernetes&logoColor=white"/>


## 주의 사항
minikube는 t2.micro(프리티어)에서는 실행되지 않습니다.



## git clone하기

```
sudo su -
mkdir git
cd git
git clone https://github.com/Kyeongrok/docker_minikube_kubectl_install
```

## Kubeadm설치는 아래 링크
- [kubeadm_readme](kubeadm_readme.md) (updated 2022-03-09)

## Docker Short Cut

sudo su - 

git clone https://github.com/Kyeongrok/docker_minikube_kubectl_install; cd docker_minikube_kubectl_install;sh docker_install.sh;


## Minikube Short Cut
git clone https://github.com/Kyeongrok/docker_minikube_kubectl_install; cd docker_minikube_kubectl_install;sh docker_install.sh; sh minikube_install.sh; sh kubectl_install.sh; sh utils.sh

## 사용 방법

sh docker_install.sh

sh minikube_install.sh

sh kubectl_install.sh

위 명령어 들을 순서대로 실행 합니다.

한번에 실행 하려면 아래와 같이 실행 합니다.

sh docker_install.sh; sh minikube_install.sh; sh kubectl_install.sh; sh utils.sh

## minikube 실행

minikube start --vm-driver=none
