# Kubernetes 구축 로드맵과 이어서 할 일

강의노트의 순서를 기준으로, 준비용 초기화 검증과 실제 클러스터 구성을 구분한다. 아래 명령은 복습용이며 자동 실행 스크립트가 아니다. 완료 여부는 오늘 대화에서 확인된 범위만 기록했다.

## 1 진행 상태

| 단계 | 상태 |
|---|---|
| master1 이름 설정과 고정 IP `.150` 적용 | 확인 완료 |
| Docker와 containerd, Kubernetes 도구 준비 | 실행 상태 및 버전 확인 |
| kubeadm init으로 컨트롤 플레인 실행 검증 | 구성 요소 Running 확인 |
| CNI 미설치로 NotReady 원인 확인 | 확인 완료 |
| sudo kubeadm reset | 성공 로그 확인 |
| master1 종료 후 워커 복제 준비 | 강의 절차에 따라 진행 |
| w1 고정 IP `.151` 및 Xshell 접속 | 사용자 확인 |
| 시간대 설정, 예비 Clone | 강의 다음 절차이며 완료 결과 미제시 |
| 실제 master1 초기화와 kubectl 사용자 설정 | 미확인 |
| Calico 설치 | 미확인 |
| w1 Join 및 두 노드 Ready | 미확인 |

## 2 공통 노드 준비 항목

다음은 강의노트의 준비 순서다. 이미 적용한 항목을 무조건 다시 실행하지 말고 현재 값을 확인한다. 특히 containerd 설정 파일을 새로 생성하면 기존 사용자 설정이 덮어써질 수 있다.

1. Ubuntu 업데이트와 재부팅.
2. 호스트 이름, `/etc/hosts`, Netplan 고정 IP 설정.
3. 실습 방화벽 상태 확인.
4. Swap 비활성화와 재부팅 후에도 비활성 상태가 유지되는지 확인.
5. 컨테이너 런타임 설치, CRI 및 systemd cgroup 설정 확인.
6. 커널 모듈과 네트워크 전달 설정 적용.
7. kubeadm·kubelet·kubectl 설치.
8. 관리자 권한으로 초기화 검증 후 reset, VM 종료.

```bash
sudo ufw status
swapon -s
sudo swapoff -a
sudo sed -i '/swap/s/^/#/' /etc/fstab
```

위 fstab 편집은 강의의 단순한 swap 항목을 전제로 한다. 수정 전 내용을 확인한다.

containerd 설정에서 `SystemdCgroup = true`인지, `disabled_plugins`에 CRI를 비활성화하는 설정이 있는지 확인한다. 설정 블록 위치는 containerd 버전에 따라 다르다.

```bash
grep -nE 'SystemdCgroup|disabled_plugins' /etc/containerd/config.toml
sudo systemctl restart containerd
sudo systemctl status containerd --no-pager
```

커널 모듈과 네트워크 설정은 양쪽 노드에 필요하다.

```bash
cat <<'EOF' | sudo tee /etc/modules-load.d/containerd.conf
overlay
br_netfilter
EOF
sudo modprobe overlay
sudo modprobe br_netfilter

cat <<'EOF' | sudo tee /etc/sysctl.d/kubernetes.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF
sudo sysctl --system
```

여기의 EOF는 터미널에서 사용하는 heredoc 끝 표시다. vi로 편집할 때는 파일 내용만 입력한다.

강의는 Kubernetes v1.36 패키지 저장소를 사용했다. 실제 노드에서 확인된 버전은 v1.36.4였다. 새 환경에서는 공식 설치 안내의 저장소·버전 호환성을 확인한다.

## 3 복제 후 워커 확인

워커 이름은 `w1`, IP는 `192.168.120.151/24`이다. 원본 마스터 IP는 `.150`으로 유지한다. 복제 직후 같은 IP가 동시에 켜지지 않도록 워커 주소부터 바꾼다.

```bash
sudo hostnamectl set-hostname w1
exec bash
sudo vi /etc/hosts
sudo vi /etc/netplan/50-cloud-init.yaml
sudo netplan generate
sudo netplan apply
```

워커 `/etc/hosts`의 로컬 호스트 이름은 `127.0.1.1 w1`로 맞춘다. master1과 w1의 주소 매핑은 양쪽에 유지한다. Netplan은 마스터와 같은 구조에서 `addresses`만 `.151/24`로 변경한다.

복제된 VM은 호스트 이름·IP뿐 아니라 MAC 주소와 시스템 UUID 등 노드 식별 정보도 중복되지 않아야 한다. VMware의 복제 기능으로 별도 VM을 만들었는지 확인한다.

양쪽 노드에서 시간대를 설정한다.

```bash
sudo timedatectl set-timezone Asia/Seoul
timedatectl
hostname
ip -br a
```

## 4 실제 클러스터 구성 예정

이 절은 다음 수업용이며 오늘 완료한 결과가 아니다.

### master1 초기화

```bash
sudo kubeadm init --pod-network-cidr=172.20.0.0/16
```

이미 초기화된 노드에서는 중복 실행하지 않는다. 수업은 Single Master 기준이다. HA 구성의 `--control-plane-endpoint`는 모든 API 서버에 도달할 수 있는 안정적인 엔드포인트여야 하며, 옵션 하나만 추가한다고 HA가 완성되는 것은 아니다.

### student의 kubectl 설정

일반 사용자 `student`로 실행한다.

```bash
mkdir -p "$HOME/.kube"
sudo cp -i /etc/kubernetes/admin.conf "$HOME/.kube/config"
sudo chown "$(id -u):$(id -g)" "$HOME/.kube/config"
kubectl get nodes -o wide
kubectl get pods -A
```

강의노트에 설정 직후 별도 `rm -rf $HOME/.kube` 줄이 있으나, 이를 연속 실행하면 방금 만든 인증 설정이 삭제된다. 실제 사용 절차에는 포함하지 않는다. 기존 config가 있다면 덮어쓰기 전 보존 여부를 확인한다.

### Calico 설치

강의노트는 Calico `v3.32.2`의 CRD, Tigera Operator, custom resources를 순서대로 적용한다. 적용 전 해당 버전의 Kubernetes 지원 범위와 공식 설치 안내를 확인한다.

1. Calico CRD 적용.
2. Tigera Operator 적용.
3. `custom-resources.yaml`을 내려받고 IP pool CIDR을 `172.20.0.0/16`으로 맞춤.
4. Custom resources 적용.
5. 네트워크 Pod와 CoreDNS 상태 확인.

```bash
kubectl get pods -A -o wide
kubectl get nodes -o wide
```

### w1 가입

master1에서 필요한 경우 새 가입 명령을 발급한다.

```bash
sudo kubeadm token create --print-join-command
```

출력된 `kubeadm join ...` 전체 명령을 워커에서 `sudo`로 실행한다. 토큰과 인증 정보는 GitHub에 올리지 않는다.

master1에서 최종 확인:

```bash
kubectl get nodes -o wide
kubectl get pods -A -o wide
```

목표는 `master1`, `w1` 모두 Ready, 네트워크 구성 요소와 CoreDNS의 정상 동작이다. 워커 VM을 만들고 SSH에 접속한 것만으로 클러스터 가입이 완료되는 것은 아니다.

## 5 reset을 사용할 때

오늘 reset은 복제 전 초기화 검증 내용을 지우기 위한 강의 단계였다. 실제 클러스터를 구축한 다음에는 NotReady라는 이유만으로 곧바로 reset하지 않고 원인을 먼저 확인한다.

reset은 kubeadm 구성을 되돌리고 로컬 etcd 데이터 등을 제거하지만, 모든 CNI 설정·네트워크 필터 규칙·사용자 kubeconfig를 자동 정리하지는 않는다. Docker 전체나 VM 디스크를 삭제하는 명령은 아니다.

## 참고

- 강의 원본: 제공된 `ktcloud-infra-k8s-강의노트.md`.
- [kubeadm 설치](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
- [클러스터 생성](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/)
- [Calico Quickstart](https://docs.tigera.io/calico/latest/getting-started/kubernetes/quickstart)
