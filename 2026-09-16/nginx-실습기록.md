# 2026-09-16 Docker Nginx 실습 기록

사용자가 제공한 터미널 출력 기준으로 기록함. 이 문서 작성 중 서버 명령을 직접 실행하지 않았음.

## 1. 사용자 실습용 폴더 준비

```bash
mkdir user
vi user/Dockerfile
```

이번에 제공된 출력에는 user/Dockerfile 내용과 test:user 빌드 결과는 포함되지 않음.

## 2. Nginx 이미지 빌드

`/root/docker_class`에서 실행:

```bash
docker build -t test:nginx nginx/
```

결과: `(9/9) FINISHED`, 약 0.5초로 빌드 완료.

참고: 전달된 기록에는 중간에 `cd nginx/`와 상위 디렉터리 프롬프트가 섞여 있음. 위 빌드 명령의 프롬프트는 `/root/docker_class`였음. `/root/docker_class/nginx`에서 빌드할 경우 마지막 경로는 `.`을 사용함.

## 3. 백그라운드 실행 및 포트 연결

```bash
cd nginx/
docker run -d -p 8080:80 test:nginx
```

반환된 컨테이너 ID:

```text
a6065ba39680705052aad0676d7c0459dfb570637bbba233213bcafeda83b57e
```

- `-d`: 터미널에서 분리하여 백그라운드 실행.
- `-p 8080:80`: 호스트의 8080 포트를 컨테이너의 80 포트에 연결.
- `--rm`을 지정하지 않았으므로 종료 후에도 컨테이너는 남음.

## 4. 실행 상태 확인

```bash
docker ps
```

제공된 출력 시점의 상태:

| 컨테이너 ID | 이미지 | 이름 | 상태 | 호스트 → 컨테이너 포트 |
|---|---|---|---|---|
| a6065ba39680 | test:nginx | loving_mahavira | Up 7 seconds | 8080 → 80 |
| bcc897239772 | chaewon121/test:nginx | chaewon-web | Up 18 hours | 83 → 80 |
| db0a82f0fdeb | d19c0eb9b9fc | web | Up 19 hours | 81 → 80 |
| 0e9c56882f25 | ubuntu | hello-world | Up 20 hours | 게시된 포트 없음 |

새 컨테이너 포트 표시: `0.0.0.0:8080->80/tcp, [::]:8080->80/tcp`.
실행 상태는 확인됐으나, 이번 기록에는 브라우저 또는 curl 접속 확인 결과는 없음.

## 5. 이미지 구성 이력 확인

```bash
docker history test:nginx
```

이미지 ID: `4a6b6c1cef36`.
출력은 최신 지시사항부터 표시되며, 확인된 주요 내용은 다음과 같음.

| CREATED BY 요약 | SIZE |
|---|---|
| EXPOSE [80/tcp] | 0B |
| COPY index.html /var/www/html/ | 4.1kB |
| CMD: /bin/sh -c를 통한 nginx -g "daemon off;" 실행 | 0B |
| RUN apt install -y nginx | 3.37MB |
| RUN apt update | 42.4MB |
| 기반 이미지의 umoci/rockcraft 구성 기록 | 0B, 4.1kB, 113MB 등 |

확인 사항:

- 이번 이미지에는 여전히 셸을 거치는 Nginx 시작 명령이 설정되어 있음.
- `COPY`는 웹페이지를 `/var/www/html/`에 포함함.
- `EXPOSE 80`은 이미지의 포트 정보이며, 실제 호스트 포트 연결은 실행 시 `-p 8080:80`으로 설정함.
- history의 `<missing>` 표시는 해당 이력에 표시할 개별 이미지 ID가 없다는 뜻이며, 그 자체로 빌드 실패를 뜻하지 않음.
- 빌드 직후에도 이력이 `19 hours ago`로 표시됨. 이는 이번 빌드 시각과 동일한 의미가 아니며, 기존 캐시 재사용과 일치하는 결과임. 상세 빌드 로그가 없어 모든 단계의 캐시 사용 여부는 확정하지 않음.

## 기록된 결과

`test:nginx` 이미지 빌드 후 새 컨테이너 `a6065ba39680`를 백그라운드로 실행했고, 호스트 8080 포트를 컨테이너 80 포트에 연결함. 기존 컨테이너들도 제공된 출력 시점에 계속 실행 중이었음.
