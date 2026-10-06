# Kubernetes 학습 목차

[전체 날짜별 기록](../README.md) · [네트워크](../Network/README.md) · [Docker](../Docker/README.md) · [AWS](../AWS/README.md)

클러스터 구축 → Pod·YAML → Deployment·Service → 배포 전략 → 모니터링·권한 순서로 복습한다.
9월 21일 내용은 기존 9월 18일 문서에 병합되어 있다.

## 주제별 찾아보기

| 주제 | 원본 기록 | 읽을 내용 |
|---|---|---|
| 전체 구조·고가용성·구성 요소 | [9/17 실습](../2026-09-17/실습.md) | 6절 |
| 노드 준비·containerd·kubeadm | [9/17 실습](../2026-09-17/실습.md) | 7절: init·join·오류 해결 |
| 구축 순서·Calico·워커 가입 | [구축 로드맵](../2026-09-17/Kubernetes-구축-로드맵.md) | 준비부터 실제 구성, reset 구분 |
| kubeconfig·taint·자동 완성 | [9/18·21 통합 노트](../2026-09-18/Kubernetes/실습.md) | 1~3절 |
| Pod IP·Service·NodePort·kube-proxy | [통합 노트](../2026-09-18/Kubernetes/실습.md) | 4절: Service 유형·selector·EndpointSlice |
| 이미지 배포·로그·이벤트·API 조회 | [통합 노트](../2026-09-18/Kubernetes/실습.md) | 5~7절 |
| 다중 컨테이너·nodeSelector | [통합 노트](../2026-09-18/Kubernetes/실습.md) | 8절: 네트워크 공유·노드 선택 |
| YAML 저장·재생성·dry-run | [통합 노트](../2026-09-18/Kubernetes/실습.md) | 9~10절 |
| Scale·Restart·삭제 복구 | [통합 노트](../2026-09-18/Kubernetes/실습.md) | 11절 |
| Label·Selector·ReplicaSet | [통합 노트](../2026-09-18/Kubernetes/실습.md) | 12절: label 변경 후 대체 생성 |
| Rolling·Blue/Green·Canary | [통합 노트](../2026-09-18/Kubernetes/실습.md) | 13절: 전환·확인·rollback |
| Metrics Server·CrashLoopBackOff | [통합 노트](../2026-09-18/Kubernetes/실습.md) | 14절: args 오류와 수정 |
| Dashboard·ServiceAccount·RBAC | [통합 노트](../2026-09-18/Kubernetes/실습.md) | 15절: 인증·권한·실습 설정 복구 |
| API Server 보안 흐름·복습 | [통합 노트](../2026-09-18/Kubernetes/실습.md) | 16~18절 |

| Helm 기초·설치·Repository | [10/6 Helm](../2026-10-06/Kubernetes/실습.md#section-1) · [설치](../2026-10-06/Kubernetes/실습.md#section-2) · [Repository](../2026-10-06/Kubernetes/실습.md#section-3) | Chart·Release·자동완성·Bitnami |
| Chart 생성·이미지·NodePort 배포 | [10/6 Chart](../2026-10-06/Kubernetes/실습.md#section-6) · [웹 배포](../2026-10-06/Kubernetes/실습.md#section-7) | values.yaml·Docker Hub 이미지·브라우저 출력 |
| Template·Upgrade·Rollback | [10/6 렌더링](../2026-10-06/Kubernetes/실습.md#section-8) · [Upgrade](../2026-10-06/Kubernetes/실습.md#section-10) · [Rollback](../2026-10-06/Kubernetes/실습.md#section-11) | kubectl 직접 관리와 Release 관리·Replica·Revision |
| MariaDB·PVC Pending·DB 접속 | [10/6 Pending](../2026-10-06/Kubernetes/실습.md#section-5) · [임시 저장 전환](../2026-10-06/Kubernetes/실습.md#section-12) · [Client 접속](../2026-10-06/Kubernetes/실습.md#section-14) | unbound PVC·비밀번호 오류·Running·SQL 확인 |
| 사용자 values·StatefulSet Scale | [10/6 설정 분리](../2026-10-06/Kubernetes/실습.md#section-15) · [Scale](../2026-10-06/Kubernetes/실습.md#section-16) · [Deployment 비교](../2026-10-06/Kubernetes/실습.md#section-17) | -f 옵션·Pod 순차 생성·고유 신원 |
| Volume·emptyDir·hostPath·PVC/PV | [10/6 Volume](../2026-10-06/Kubernetes/실습.md#section-18) · [hostPath](../2026-10-06/Kubernetes/실습.md#section-19) | 데이터 수명·노드 종속·영구 저장 개념 |
| Helm 오류·명령어 복습 | [10/6 트러블슈팅](../2026-10-06/Kubernetes/실습.md#section-20) · [명령 모음](../2026-10-06/Kubernetes/실습.md#section-22) | Pending·Release 부재·Upgrade Password 오류 |

## 재사용 YAML

- [Deployment 예제](../2026-09-18/Kubernetes/examples/deployment-example.yaml)
- [컨테이너 두 개를 가진 Pod 예제](../2026-09-18/Kubernetes/examples/pod-two-containers.yaml)

예제는 기존 위치의 파일을 연결한다. 실제 적용 전 현재 리소스·이미지·네임스페이스와 문서의 전제 조건을 확인한다.

## 오류와 확인 범위

- kubeconfig 미설정, 이미지 pull, YAML 필드 오류: 통합 노트 1·5·8절
- Metrics Server 인자 결합 오류: 통합 노트 14절
- Dashboard는 당시 구버전 실습 기록이며, 운영 권장 설정과 구분한다.
- Canary 실제 트래픽 측정 및 일부 검증 명령은 완료 기록이 없다. 통합 노트 17절을 함께 읽는다.

새 실습은 날짜별 원본에 기록하고 이 목차의 관련 항목에 연결한다.
