# Terraform 학습 목차

[전체 날짜별 기록](../README.md) · [Kubernetes](../Kubernetes/README.md) · [AWS](../AWS/README.md)

전체 실습 내용은 날짜별 원본에 보관하고, 이 폴더에서 Terraform 관련 절로 바로 이동한다.

## 주제별 찾아보기

| 주제 | 원본 기록 | 읽을 내용 |
|---|---|---|
| IaC·Terraform·CloudFormation·OpenTofu | [10/12 개념](../2026-10-12/실습.md#section-8) | 선언형 구성·Provider/Module·Registry |
| Windows·Git Bash·VS Code 환경 | [10/12 설치](../2026-10-12/실습.md#section-9) | PATH·tf alias·프로필 적용·교안 저장소 Clone |
| Local Provider 첫 실습 | [10/12 local_file](../2026-10-12/실습.md#section-10) | main.tf·init→plan→apply→destroy·abc.txt 생성/검증/삭제 |
| 설치 및 초기화 오류 | [10/12 트러블슈팅](../2026-10-12/실습.md#section-11) | 명령 검색 실패·프로필 경로 오타·미저장 main.tf |
| State·잠금 파일·Git 관리 | [10/12 State](../2026-10-12/실습.md#section-10) · [업로드 주의사항](../2026-10-12/실습.md#section-12) | tfstate 제외·.terraform 캐시·.terraform.lock.hcl |

## 확인한 범위

10/12 첨부 기록에서는 Windows 환경 구성과 Local Provider의 파일 생성·확인·삭제를 완료했다. AWS 인프라를 Terraform으로 생성한 기록은 아니다. 버전과 경로는 당일 실습 기록 기준이다.

새 Terraform 실습도 날짜별로 저장한 뒤 이 목차에 링크를 추가한다.
