# Kubeadm으로 K8s설치

<img src="https://img.shields.io/badge/kubernetes-brightgreen?logo=Kubernetes&logoColor=white"/>

## kubeadm설치
```
sh kubeadm_install.sh
```
## 설치 후 작업
- CNI(Calico)설치 https://projectcalico.docs.tigera.io/getting-started/kubernetes/quickstart
- worker join

## kubeadm join command print
join command가 나오게 하는 명령어 입니다.
```
kubeadm token create --print-join-command
```

