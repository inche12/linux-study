# 2026-09-18 KT Cloud 실습

실습일: 2026-09-18. 정리일: 2026-09-20.
사용자가 제공한 명령 출력·스크린샷을 바탕으로 작성했다. 서버를 직접 조작하거나 현재 상태를 재검증하지 않았다.

## 분야별 기록

- [Docker: 기존 이미지 확인과 Docker Hub 업로드](Docker/실습.md)
- [Kubernetes: 구축 확인부터 Deployment까지](Kubernetes/실습.md)

9월 21일 후속 학습은 위 Kubernetes 문서에 병합했다. Service·kube-proxy, nodeSelector,
Rolling/Blue-Green/Canary, Metrics Server 오류, Dashboard·ServiceAccount·RBAC를 추가했다.
[AWS 기초 학습](../2026-09-21/AWS/실습.md)은 별도 문서로 연결한다.
아래 완료 체크와 환경·인계 정보는 **9월 18일 당시 상태**다. 9월 21일의 기록/검증 범위는 통합 노트를 참고한다.

## 완료 체크

- [x] master1, w1 Ready 확인
- [x] student kubeconfig 설정 및 kubectl 조회 성공
- [x] master1 control-plane taint 제거
- [x] Bash 자동 완성, k 별칭 설정; 미설치 Helm 자동 완성 주석 처리
- [x] Nginx Pod 생성, Pod IP·ClusterIP·NodePort 접속 확인
- [x] Docker 이미지 업로드 문제 해결 및 개인 웹페이지 표시 확인
- [x] 다중 컨테이너 Pod와 네트워크 공유 확인
- [x] YAML 생성·조회·삭제·재생성·템플릿 정리
- [x] client/server dry-run 비교
- [x] Deployment 복제본 3개, Pod 삭제 후 자동 대체 생성 확인
- [x] nginx Deployment 추가 생성
- [ ] Xshell 유휴 연결 끊김의 최종 해결 여부 미확인
- [ ] example/nginx Deployment용 Service 생성 결과 미제시

## 환경

| 위치 | 주소 | 역할 |
|---|---|---|
| 예전 노트북 Rocky10/s1 | 192.168.120.128 | Docker 원본 이미지·Dockerfile 보관, Docker Hub push |
| 예전 Ubuntu | 192.168.120.129 | Docker 실습 서버 |
| 새 노트북 master1 | 192.168.120.150 | Kubernetes control-plane, 일반 Pod 배치도 허용 |
| 새 노트북 w1 | 192.168.120.151 | Kubernetes worker |

Kubernetes v1.36.4, Calico 사용. IP는 당시 실습망 기준이며 새 환경에서 확인해야 한다.

## 다른 Codex에서 이어가기

저장소 inche12/linux-study의 이 날짜 폴더와 2026-09-17 기록을 읽고 진행한다.
마지막으로 확인된 앱 구성은 example Deployment 3개 Pod, nginx Deployment 1개 Pod이다.
web·lsm·mypod·mypod-1·nginx-pod 단독 Pod는 default 네임스페이스 전체 Pod 삭제 실습에서 삭제됐다.
web/lsm Service는 남았지만 각각 run=web/run=lsm을 찾으므로 app=example/app=nginx Pod에는 연결되지 않는다.
개인 웹페이지 성공 기록은 삭제 이전의 결과이며 현재 서비스 상태로 오해하지 않는다.

다음 조회로 실제 상태부터 재확인:

```bash
kubectl get nodes
kubectl get deploy,rs,po,svc -o wide --show-labels
kubectl get pods -A
```

Git은 실습 문서와 YAML을 보관하며 VM·클러스터·컨테이너 데이터·대화 전체를 자동 백업하지 않는다.
개인 인증 토큰, Docker PAT, kubeconfig 원문, 가입 명령의 실제 토큰은 포함하지 않았다.
강의 PDF 원본은 재배포하지 않는다.

## 노션 가져오기

별도 제공한 ZIP은 이 폴더의 Markdown 문서와 재사용 YAML을 포함한다.
압축을 풀어 Markdown 문서들을 Notion의 Markdown 가져오기 기능으로 가져올 수 있다.
앱에서 ZIP 가져오기가 지원되면 ZIP을 선택할 수 있다. 표와 코드 블록 중심이며 직접 노션 계정에 게시한 것은 아니다.
