# linux-study — KT CLOUD 실습 기록

## 분야별 공부 바로가기

| 네트워크 | Docker | Kubernetes | AWS |
|---|---|---|---|
| [네트워크 목차](Network/README.md) | [Docker 목차](Docker/README.md) | [Kubernetes 목차](Kubernetes/README.md) | [AWS 목차](AWS/README.md) |
| IP·DNS·라우팅·SSH·패킷 분석 | 이미지·Dockerfile·Volume·Compose | 구축·Pod·Service·배포·RBAC | IAM·EC2·S3·VPC·연결 오류 |

**날짜별 기록은 실습 원본**, **분야별 폴더는 주제별 학습 목차**다. 분야별 목차에서 관련 날짜의 문서와 예제로 이동한다.
여러 분야가 섞인 실습은 각 목차에서 같은 원본의 관련 절을 안내한다.

새 실습은 계속 날짜별 폴더에 기록하고, 아래 날짜 목차와 해당 분야의 목차에 링크를 추가한다.
내용 수정은 날짜별 원본에서 하므로 두 곳의 본문을 따로 관리할 필요가 없다.

## 날짜별 실습 기록

날짜별 폴더에 실습을 정리하며, 필요한 날짜는 오전·오후로 나눈다. 실제 실행 결과와 개념 설명·보충 예시를 구분한다. 8/20~9/7 자료는 강의노트1에서 정리했으며 VMware 설치 과정과 비밀번호·암호 해시는 제외했다.

| 날짜 | 기록 | 주요 내용 |
|---|---|---|
| 2026-08-20 | [실습](2026-08-20/실습.md) | 디스크·DNS·IP·라우팅·소켓 확인 |
| 2026-08-21 | [실습](2026-08-21/실습.md) | su·SSH·원격 접속 |
| 2026-08-24 | [실습](2026-08-24/실습.md) | 파일·하드 링크·심볼릭 링크 |
| 2026-08-25 | [실습](2026-08-25/실습.md) | 특수 권한·그룹 공유·PATH·PS1 |
| 2026-08-26 | [실습](2026-08-26/실습.md) | vim·grep·find·좀비 프로세스·Docker 설치 |
| 2026-08-27 | [실습](2026-08-27/실습.md) | Nginx 컨테이너·확장 glob·sed |
| 2026-08-28 | [실습](2026-08-28/실습.md) | awk 로그 분석·Ubuntu·umask·Docker 그룹 |
| 2026-09-07 | [실습](2026-09-07/실습.md) | sudo·PAM·systemd·NTP·스케줄링·디스크 |
| 2026-09-08 | [실습](2026-09-08/실습.md) | LVM Snapshot·tar 경로 오류·watch·RAID1·Swap·fstab 오타·GitHub SSH 443 |
| 2026-09-09 | [기존 실습 노트](notes/2026-09-09-linux-practice.md) | 부팅 설정·백업·복원·원격 복사·로그·방화벽 조회 |
| 2026-09-10 | [오전 실습](2026-09-10/오전%20실습.md) | SSH 오타 해결, Apache·SELinux·82번 포트, IP·PAT·서브네팅·슈퍼네팅, 추가 IP 통신 |
| 2026-09-10 | [오후 실습](2026-09-10/오후%20실습.md) | IP 변경 별도 표시, NetworkManager·Netplan, Windows–Rocky–Ubuntu 라우팅, SSH 220·공개키, 트러블슈팅 모음 |
| 2026-09-11 | [실습 및 네트워크 정리](2026-09-11/실습%20및%20네트워크%20정리.md) | SCP·SFTP, SSH 오류, NFS·방화벽·마운트, IPv6, Podman, OSI·PDU·이더넷, RIP, VPC Peering |
| 2026-09-14 | [실습](2026-09-14/실습.md) · [패킷 분석](2026-09-14/패킷%20분석.md) | DNS·Unbound·SELinux, Nmap·RPC·nc·lsof, NAT·TTL, Wireshark 분석·IPv4/IPv6·HTTP·TCP handshake·MSS |
| 2026-09-15 | [실습](2026-09-15/실습.md) | Docker 구조·권한·원격 API, 이미지·컨테이너·프로세스, Dockerfile·Nginx 웹 배포, Docker Hub·포트 충돌 해결 |
| 2026-09-16 | [Docker 종합 정리](2026-09-16/9월16일-Docker-종합정리.md) | Dockerfile·이미지·볼륨·Nginx·사설 레지스트리 |
| 2026-09-17 | [실습 정리](2026-09-17/실습.md) · [Kubernetes 구축 로드맵](2026-09-17/Kubernetes-구축-로드맵.md) | 멀티 플랫폼 이미지·Docker 네트워크·Compose·WordPress·MySQL·Kubernetes 구조·고정 IP·kubeadm 검증과 reset·워커 준비 |
| 2026-09-18 | [분야별 목차](2026-09-18/README.md) · [Kubernetes](2026-09-18/Kubernetes/실습.md) | Docker Hub 업로드·kubeconfig·Pod·YAML·Deployment·삭제 복구 |
| 2026-09-21 | [Kubernetes 통합 노트](2026-09-18/Kubernetes/실습.md) · [AWS 기초](2026-09-21/AWS/실습.md) | Service·kube-proxy·label/nodeSelector·배포 전략·Metrics Server 오류·Dashboard·SA/RBAC·AWS 서비스 모델·Region/AZ·IAM |
| 2026-09-22 | [AWS 실습](2026-09-22/AWS/실습.md) | IAM·Role/STS·Cross Account·S3 권한·EC2·VPC 및 집 Wi-Fi/핫스팟 SSH 장애 |
| 2026-09-23 | [AWS 실습](2026-09-23/AWS/실습.md) | S3 공개 접근·Presigned URL·CLI·백업·정적 웹사이트·403/fetch 오류·VPC 설계·비용 점검 |
| 2026-09-28 | [AWS 실습](2026-09-28/AWS/실습.md) | VPC·Bastion·Private EC2·NAT·ProxyCommand·리전 간/짝꿍 Peering·EFS·트러블슈팅·삭제 점검 |
| 2026-09-29 | [AWS 실습](2026-09-29/AWS/실습.md) | Public Subnet·EC2 User Data·Apache/PHP·특수 대시 오류·ALB/Target Group·Auto Scaling 사전 학습·비용 확인 |

9월 21일 Kubernetes 내용은 기존 9월 18일 문서의 관련 항목에 병합했다. 날짜별 중복 문서를 만들지 않고 기존 실행 기록과 추가 확인 절차를 구분한다.

기존 셸 스크립트와 예제 데이터는 저장소 루트에 유지한다. 강의노트의 전체 Word 원본은 업로드하지 않고 날짜별 정리본을 제공한다.
