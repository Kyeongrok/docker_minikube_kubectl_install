# Kubeadm으로 K8s설치

<img src="https://img.shields.io/badge/kubernetes-brightgreen?logo=Kubernetes&logoColor=white"/>

## kubeadm설치
```
sh kubeadm_install.sh
```
## 설치 후 작업
- CNI(Calico)설치 https://projectcalico.docs.tigera.io/getting-started/kubernetes/quickstart
- 또는 wget https://docs.projectcalico.org/manifests/calico.yaml 명령어로 calico.yaml다운로드 후 apply
- worker join

## kubeadm join command print
join command가 나오게 하는 명령어 입니다.
```
kubeadm token create --print-join-command
```

## Isseue
```
"Failed to run kubelet" err="failed to run Kubelet: misconfiguration: kubelet cgroup driver: \"cgroupfs\" is different from docker cgroup driver: \"systemd\"
```
위 메세지 나오면서 kubelet이 실행 안되는 경우
