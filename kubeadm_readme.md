# Kubeadm으로 K8s설치

<img src="https://img.shields.io/badge/kubernetes-brightgreen?logo=Kubernetes&logoColor=white"/>

## 설치 전에 확인 할 것
- 방화벽 port가 오픈 되어 있는지 확인 합니다.
  - Master node
    - TCP - Inbound - 6443 : Kubernetes API Server
    - TCP - Inbound - 2379~2380: Etcd server client API (used by kube-apiserver, etcd)
    - TCP - Inbound - 10250: Kubelet API (used by Self, Control plane)
    - TCP - Inbound - 10251: kube-scheduler (used by Self)
    - TCP - Inbound - 10252: kube-controller-manager (used by Self)
  - Worker node
    - TCP - Inbound - 10250: Kubelet API (used by Self, Control plane)
    - TCP - Inbound - 30000~32767: NodePort Services (used by All)
  - UDP(All node)
    - 8285, 8472

 
## kubeadm설치
```
sudo -i
sh kubeadm_install.sh
```
## 설치 후 작업

### root일 때 kubectl권한 넣기
user에서는 쓰지 마세요
```
export KUBECONFIG=/etc/kubernetes/admin.conf
```

### Taint풀기
```
kubectl taint nodes --all node-role.kubernetes.io/master-
```

### Calico
- CNI(Calico)설치 https://projectcalico.docs.tigera.io/getting-started/kubernetes/quickstart
```
kubectl create -f https://projectcalico.docs.tigera.io/manifests/tigera-operator.yaml
kubectl create -f https://projectcalico.docs.tigera.io/manifests/custom-resources.yaml
```
- 또는 wget https://docs.projectcalico.org/manifests/calico.yaml 명령어로 calico.yaml다운로드 후 apply
- worker join
  - kubeadm_worker_install.sh를 이용해 kubectl, kubelet, kubeadm을 설치 후 master의 join명령어로 join합니다.

## Flannel
 - 10.244.0.0/16 를 cidr로 해주어야 합니다.
 - kubectl apply -f https://raw.githubusercontent.com/flannel-io/flannel/master/Documentation/kube-flannel.yml

## kubeadm join command print
join command가 나오게 하는 명령어 입니다.
```
kubeadm token create --print-join-command
```

## worker node에 스크립트 실행
- 실행 하기 전에 host에 controlplane이 추가 되어 있는지 확인 합니다
/etc/hosts

```
kubeadm_worker_install.sh
```

## Cgroup확인
```
docker info | grep -i cgroup
```

## Isseue
```
"Failed to run kubelet" err="failed to run Kubelet: misconfiguration: kubelet cgroup driver: \"cgroupfs\" is different from docker cgroup driver: \"systemd\"
```
위 메세지 나오면서 kubelet이 실행 안되는 경우

# [preflight] Running pre-flight checks
위 메세지에서 안넘어가고 Timeout이 나는 경우는 6443포트와 통신이 안되기 때문일 수 있습니다. 6443포트를 열어 주시면 됩니다.

