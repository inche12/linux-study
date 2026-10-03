# AWS 학습 목차

[전체 날짜별 기록](../README.md) · [네트워크](../Network/README.md) · [Docker](../Docker/README.md) · [Kubernetes](../Kubernetes/README.md)

클라우드 기초 → IAM·Role → EC2·SSH → S3·CLI → 정적 웹사이트 → VPC 순서로 복습한다.
각 링크는 날짜별 원본으로 이동한다.

## 주제별 찾아보기

| 주제 | 원본 기록 | 읽을 내용 |
|---|---|---|
| IaaS·PaaS·SaaS·공유 책임 | [9/21 AWS 기초](../2026-09-21/AWS/실습.md) | 1~2절 |
| Region·AZ·VPC·Subnet | [9/21 AWS 기초](../2026-09-21/AWS/실습.md) | 3~4절 |
| IAM User·Group·Policy·Role | [9/21 기초](../2026-09-21/AWS/실습.md) · [9/22 실습](../2026-09-22/AWS/실습.md) | 기초 5절, 실습 2절 정책 종류·MFA |
| Access Key·CLI 인증 | [9/22 실습](../2026-09-22/AWS/실습.md) · [9/23 CLI](../2026-09-23/AWS/실습.md#04) | 프로파일·임시 자격 증명·현재 호출자 |
| Role·Trust Policy·STS | [9/22 실습](../2026-09-22/AWS/실습.md) | 4절: 신뢰 관계와 권한 분리 |
| Cross Account AssumeRole | [9/22 실습](../2026-09-22/AWS/실습.md) | 5~6절: Role 프로파일·S3 권한 |
| EC2·PEM·Instance Profile | [9/22 실습](../2026-09-22/AWS/실습.md) | 7~8절: SSH 인증과 AWS API 권한 구분 |
| SSH 연결 실패·집 Wi-Fi/핫스팟 | [9/22 장애 요약](../2026-09-22/AWS/실습.md#ssh-troubleshooting) | 확인한 결과와 아직 남은 원인 |
| S3 ACL·버킷 정책·공개 차단 | [9/23 S3 공개 접근](../2026-09-23/AWS/실습.md#02) | 공개 읽기와 업로드 권한 구분 |
| Object URL·Presigned URL | [9/23 임시 URL](../2026-09-23/AWS/실습.md#03) | 서명·권한·만료 |
| S3 cp·sync·백업 | [9/23 CLI 명령](../2026-09-23/AWS/실습.md#05) · [백업](../2026-09-23/AWS/실습.md#06) | 버킷/객체 ARN·prefix·동기화 |
| 정적 웹사이트·Hello World | [9/23 웹사이트](../2026-09-23/AWS/실습.md#07) | HTML·호스팅·공개 정책 |
| 403 AccessDenied | [9/23 오류 진단](../2026-09-23/AWS/실습.md#08) | 객체 키·권한·공개 차단 |
| 프론트엔드·fetch·CORS·ELB | [9/23 프론트엔드](../2026-09-23/AWS/실습.md#09) | URL 중복·브라우저 API 요청·추가 확인 |
| VPC·IGW·NAT·Peering | [9/23 네트워크 개념](../2026-09-23/AWS/실습.md#10) | Public/Private 경로와 보안 그룹 |
| 서울 VPC·서브넷 설계 | [9/23 VPC 실습](../2026-09-23/AWS/실습.md#11) | 10.26.0.0/16, AZ 2개·서브넷 4개 |
| 비용·중지·정리 | [9/23 종료 점검](../2026-09-23/AWS/실습.md#12) | EC2·EBS·NAT·EIP·ELB |
| GitHub 업로드 전 점검·복습 | [9/23 점검](../2026-09-23/AWS/실습.md#13) · [복습](../2026-09-23/AWS/실습.md#14) | 인증 정보 제외·후속 학습 |
| VPC·Subnet·IGW·RT 수동 구성 | [9/28 네트워크](../2026-09-28/AWS/실습.md#03) | 10.126.0.0/16·서브넷 연결·가장 구체적인 경로 |
| Bastion·Private EC2·NAT | [9/28 SSH](../2026-09-28/AWS/실습.md#04) · [NAT](../2026-09-28/AWS/실습.md#05) | 2단계 접속·Private 인터넷 출구·패키지 설치 |
| Windows SSH config·ProxyCommand | [9/28 접속 설정](../2026-09-28/AWS/실습.md#06) | 로컬 키로 Bastion 경유 접속 |
| 서울↔오리건·짝꿍 VPC Peering | [9/28 리전 간 연결](../2026-09-28/AWS/실습.md#07) · [짝꿍 ping](../2026-09-28/AWS/실습.md#08) | 양방향 경로·출발지·확인 결과 |
| EFS 생성·TLS 마운트·파일 공유 | [9/28 EFS](../2026-09-28/AWS/실습.md#09) · [짝꿍 공유](../2026-09-28/AWS/실습.md#10) | Mount Target·TCP 2049·파일 읽기/쓰기 |
| SSH·EFS·경로 오류 해결 | [9/28 트러블슈팅](../2026-09-28/AWS/실습.md#11) | DNS·known_hosts·config.txt·잘못된 대상 및 경로 |
| SG·NACL·실습 종료 | [9/28 보안 규칙](../2026-09-28/AWS/실습.md#12) · [비용](../2026-09-28/AWS/실습.md#13) · [삭제 체크리스트](../2026-09-28/AWS/실습.md#16) | Stateful/Stateless·정리 보고와 재점검 |
| Public Subnet·웹 서버 EC2 | [9/29 네트워크 구성](../2026-09-29/AWS/실습.md#3-기존-vpc--subnet--route-table-구조) · [EC2 생성](../2026-09-29/AWS/실습.md#5-ec2-webserver-1-생성) | Public RT 연결·공인 IP·HTTP 접근 조건 |
| User Data·Apache/PHP 자동 구성 | [9/29 User Data](../2026-09-29/AWS/실습.md#7-고급-세부-정보---user-data) · [명령 해석](../2026-09-29/AWS/실습.md#8-user-data-명령어-상세-해석) | 패키지 설치·웹 앱 배치·SDK |
| httpd 시작 실패·Cloud-init 로그 | [9/29 오류 해결](../2026-09-29/AWS/실습.md#9-웹-접속-실패-트러블슈팅) · [로그 확인](../2026-09-29/AWS/실습.md#10-cloud-init-로그-및-웹-파일-확인) | 특수 대시·inactive·enable --now·웹페이지 정상 출력 |
| ALB·Target Group·Health Check | [9/29 ALB 복습](../2026-09-29/AWS/실습.md#4-기존-alb-실습-구조-복습) | HTTP Listener·Healthy Target·EC2 두 대 |
| Launch Template·Auto Scaling 사전 학습 | [9/29 개념](../2026-09-29/AWS/실습.md#13-auto-scaling-사전-학습) · [실제 확인 범위](../2026-09-29/AWS/실습.md#14-asg-화면에서-실제-확인한-내용) | Min/Desired/Max·ASG는 아직 미생성 |
| 리소스 정리·Billing 확인 | [9/29 종료 점검](../2026-09-29/AWS/실습.md#16-실습-종료-후-비용-절감-포인트) · [비용 화면](../2026-09-29/AWS/실습.md#17-billing-화면에서-비용-확인) | EC2·ALB·NAT·EBS·예상 비용과 결제 구분 |
| DynamoDB·Query/Scan·읽기 일관성 | [10/2 DynamoDB](../2026-10-02/AWS/실습.md#section-2) | Item·키·Capacity Mode |
| Serverless·이벤트 처리·SAM | [10/2 서버리스](../2026-10-02/AWS/실습.md#section-3) · [SAM](../2026-10-02/AWS/실습.md#section-4) | API Gateway·Lambda·EventBridge·SQS·DLQ 개념 |
| CAF·마이그레이션·데이터 전송 | [10/2 CAF](../2026-10-02/AWS/실습.md#section-5) · [전략](../2026-10-02/AWS/실습.md#section-6) · [전송 서비스](../2026-10-02/AWS/실습.md#section-7) | 6R 학습·Storage Gateway·DataSync·Transfer Family |
| CloudFront·OAI/OAC·Signed URL | [10/2 CDN](../2026-10-02/AWS/실습.md#section-8) · [보안 개념](../2026-10-02/AWS/실습.md#section-9) | Origin·Edge·TTL·접근 제어 |
| Docker 3-Tier·ALB 3000 포트 연동 | [10/2 컨테이너 확인](../2026-10-02/AWS/실습.md#section-10) · [504 해결](../2026-10-02/AWS/실습.md#section-15) | MySQL·Backend 재시작·/api Health Check·SG |
| S3 Frontend·CloudFront 두 배포 | [10/2 S3 이전](../2026-10-02/AWS/실습.md#section-17) · [Frontend CDN](../2026-10-02/AWS/실습.md#section-20) · [Backend CDN](../2026-10-02/AWS/실습.md#section-23) | 정적 파일·HTTPS API·Origin Path |
| 캐시 무효화·최종 DB 조회·정리 | [10/2 Invalidation](../2026-10-02/AWS/실습.md#section-27) · [최종 결과](../2026-10-02/AWS/실습.md#section-28) · [오류 복습](../2026-10-02/AWS/실습.md#section-30) · [종료 점검](../2026-10-02/AWS/실습.md#section-31) | HTML 갱신·Mixed Content·리소스 정리 절차 |

## 기록을 읽을 때

- 9/21은 기초 개념 학습이다.
- 9/22의 계정 번호는 공개용 대체값이며 실제 실행 시 자신의 값으로 바꾼다.
- 집 SSH 연결 실패의 정확한 차단 위치는 아직 확정되지 않았다.
- 9/23의 본인 ELB/API 연결 성공, 최종 VPC 상태, NAT 생성 여부와 EC2 중지 완료는 해당 원문에서 추가 확인 대상으로 구분한다.
- 9/28은 별도 example-vpc 실습이다. Private SSH·짝꿍 ping·본인 EFS 쓰기는 성공 기록이 있고, 오리건 사설 ping과 상대 EFS 공유 결과는 미확인이다. 삭제 완료는 사용자 보고이며 개별 잔여 리소스는 재점검 대상이다.

- 9/29는 User Data 웹 서버 동작과 기존 ALB 구성을 확인한 기록이다. Auto Scaling은 사전 학습이며 실제 ASG 생성 완료로 기록하지 않는다.

- 10/2는 첨부 기록 기준으로 CloudFront 프론트엔드에서 DB 데이터 표시까지 확인했다. 서버리스·마이그레이션 개념 학습과 실제 3-Tier 연동을 구분하며, 리소스 정리 절차를 삭제 완료 증거로 보지 않는다.

## 다음 기록 추가 방법

새 AWS 실습은 날짜별 폴더의 원본에 기록한 뒤 이 표에 링크를 추가한다. 기존 명령·결과를 수정할 때도 원본만 갱신한다.
네트워크 기초가 필요하면 [네트워크 목차](../Network/README.md)로 이동한다.
