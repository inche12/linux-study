# 2026-09-16 Docker 볼륨 실습

사용자가 제공한 Dockerfile과 터미널 결과를 정리함.

## Dockerfile 및 오류 수정

```dockerfile
FROM ubuntu
VOLUME /app
CMD touch /app/hello.txt; ls -l /app
```

처음에는 `ls-l`로 작성하여 명령을 찾지 못함. `ls -l`로 공백을 넣어 수정하는 방법을 안내했고, 이후 제공된 실행 결과에서 파일 목록 출력에 성공함.

## 실행 결과

1. `/var/lib/docker/volumes`에 처음에는 `backingFsBlockDev`, `metadata.db`만 보였음.
2. `docker run test:vol` 실행 후 `/app/hello.txt`가 생성되고 목록이 출력됨.
3. 익명 볼륨 `31abf87b2dcc55362754a2ef24f3dc8c4934c5254515e6b18a1536cb8dfe8d8f`가 생성됨.
4. 호스트의 해당 볼륨 디렉터리 아래 `_data/hello.txt`가 확인됨.
5. 컨테이너 `8ccd047a2b54` (`infallible_shannon`)는 `Exited (0)`으로 정상 종료됨.
6. `docker rm 8cc`로 컨테이너 삭제 후에도 볼륨과 `_data/hello.txt`는 남아 있었음.

## 의미

- `VOLUME /app` 선언으로 컨테이너 생성 시 `/app`에 볼륨이 연결됨. 이번 실행에서는 별도 볼륨을 지정하지 않아 임의의 긴 이름을 가진 익명 볼륨이 생성됨.
- 관찰된 연결: 컨테이너 `/app/hello.txt` ↔ 호스트 `/var/lib/docker/volumes/31abf87b2dcc55362754a2ef24f3dc8c4934c5254515e6b18a1536cb8dfe8d8f/_data/hello.txt`.
- 일반 `docker rm`은 컨테이너만 삭제하므로 볼륨 데이터가 남음.
- `docker run --rm`은 종료 시 컨테이너와 연결된 익명 볼륨도 삭제함. 이름을 지정한 볼륨은 이 옵션으로 삭제되지 않음.
- 같은 이미지를 다시 `docker run`하면 새 익명 볼륨이 생기며 이전 익명 볼륨이 자동으로 재사용되지는 않음.
- 이번 기록의 `/var/lib/docker/volumes` 경로는 해당 실습 환경에서 확인한 경로임.
