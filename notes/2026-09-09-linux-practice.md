# Linux 실습 정리 — 2026-09-09

Rocky Linux 10과 Ubuntu에서 진행한 부팅 설정, 백업·복원, 원격 복사, 로그 관리, 방화벽 조회 실습 기록이다. 실제 명령과 출력으로 확인한 내용을 중심으로 정리했다. 비밀번호나 시스템 파일의 실제 내용은 포함하지 않았다.

## 1. GRUB 부팅 설정

```bash
cat /etc/default/grub
ls /etc/grub*
vi /etc/default/grub
cp /boot/grub2/grub.cfg /boot/grub2/grub.cfg.bk
grub2-mkconfig -o /boot/grub2/grub.cfg
reboot
```

- `/etc/default/grub`: GRUB 기본 설정.
- `/etc/grub.d/`: 설정 생성에 사용하는 스크립트.
- `/boot/grub2/grub.cfg`: 생성된 부팅 설정.
- 같은 파일을 원본과 대상으로 지정한 `cp`는 실패했다. `.bk` 이름으로 백업했다.
- `grub2-mkconfig`는 `done`으로 완료됐다. 실제로 변경한 설정값은 기록에 없다.
- `GRUB_CMDLINE_LINUX` 같은 커널 인자는 BLS 사용 여부와 버전에 따라 별도 적용 확인이 필요하다. 설정 생성 성공만으로 모든 커널 인자 적용을 단정하지 않는다.

재부팅 때 나온 `Installing Updates…` 화면은 업데이트 진행 화면이다. Plymouth에서 Esc는 그래픽 화면과 상세 메시지 화면 전환에 사용된다. Esc가 업데이트를 시작시켰다는 근거는 없다.

## 2. 실행 수준과 systemd 타깃

| 전통적 실행 수준 | 의미 | 현대 명령 예시 |
|---|---|---|
| 0 | 전원 종료 | `systemctl poweroff` |
| 1, s | 복구용 단일 사용자 모드 | `systemctl rescue` |
| 3 | 텍스트 다중 사용자 모드 | `systemctl isolate multi-user.target` |
| 5 | 그래픽 모드 | `systemctl isolate graphical.target` |
| 6 | 재부팅 | `systemctl reboot` |

```bash
systemctl get-default
systemctl isolate multi-user.target
systemctl set-default multi-user.target
```

`get-default`는 기본 부팅 타깃 조회, `isolate`는 지금 전환, `set-default`는 이후 부팅 기본값 설정이다. 전환 시 기존 서비스나 세션이 종료될 수 있다. 일반 부팅이 복구용 단일 사용자 모드를 반드시 거치는 것은 아니다. 강의 그림의 `e → single → b`는 옛 GRUB 절차이므로 GRUB2에 그대로 적용하지 않는다.

## 3. XFS 전체·증분 백업

```bash
mkdir /bk
xfsdump -l0 -f /bk/xfs.dump0 /xfs
xfsrestore -t -f /bk/xfs.dump0
cp /etc/t* /xfs
xfsdump -F -l1 -f /bk/xfs.dump1 /xfs
cp /etc/v* /xfs
xfsdump -F -l2 -f /bk/xfs.dump2 /xfs
xfsrestore -t -f /bk/xfs.dump1
xfsrestore -t -f /bk/xfs.dump2
```

| 백업 | 확인된 내용 |
|---|---|
| Lv0 | `favicon.png`, `filesystems`, `fprintd.conf`, `fstab`, `fuse.conf` |
| Lv1 | `trusted-key.key` |
| Lv2 | `vconsole.conf`, `vimrc`, `virc` |

세 백업 모두 `Dump Status: SUCCESS`였다. `-l`은 백업 레벨, `-f`는 백업 파일 지정, `-F`는 대화형 질문 없이 진행하는 옵션이다. 라벨을 생략했다는 경고는 이번 기록에서 백업 실패를 의미하지 않았다. `xfsrestore -t`는 내용 조회이며 실제 복원이 아니다.

### 증분과 차등의 기준

- 일반적인 증분 백업: 직전 기준 백업 이후 변경분을 저장한다.
- 차등 백업: 마지막 전체 백업 이후 누적 변경분을 저장한다.
- **xfsdump의 정확한 규칙: 현재 레벨보다 숫자가 작은 백업 중 가장 최근 백업을 기준으로 한다.** 따라서 레벨을 어떻게 배치하느냐에 따라 기준 시점이 달라진다.

강의 달력 예시:

| 날짜 | 레벨 | 기준 | 범위 |
|---|---|---|---|
| 1일 | 0 | 없음 | 전체 |
| 8일 | 1 | 1일 Lv0 | 1일 이후 누적 |
| 15일 | 1 | 1일 Lv0 | 1일 이후 누적 |
| 18일 | 2 | 15일 Lv1 | 15일 이후 |
| 19일 | 3 | 18일 Lv2 | 18일 이후 |
| 20일 | 4 | 19일 Lv3 | 19일 이후 |
| 21일 | 5 | 20일 Lv4 | 20일 이후 |
| 22일 | 1 | 1일 Lv0 | 1일 이후 누적 |

21일 상태 복원에는 `1일 Lv0 → 15일 Lv1 → 18일 Lv2 → 19일 Lv3 → 20일 Lv4 → 21일 Lv5`가 필요하다. 22일 상태에는 `1일 Lv0 → 22일 Lv1`이 필요하다. 이는 필요한 백업 체인 설명이며 실제 누적 복원 명령 실행 기록은 없다.

Lv1을 반복하면 차등 방식으로 작동하지만 xfsdump 매뉴얼에서는 Lv1~9를 incremental dump라고 부른다. 높은 숫자가 더 많은 데이터를 뜻하지 않는다. 누적 백업은 과거 백업 파일들을 합치는 작업이 아니라, 기준 이후 변경된 원본 파일의 백업 시점 상태를 저장하는 작업이다.

## 4. 대화형 선택 복원

`/re`에서 실행했다.

```bash
xfsrestore -i -f /bk/xfs.dump0 .
```

대화형 명령:

```text
ls
add fstab
ls
extract
```

`add fstab` 뒤의 `*`는 복원 대상으로 선택됐다는 표시다. 정상 추출되면 대상은 `/re/fstab`이다. 기록은 `extract` 입력까지이므로 완료 출력은 확인되지 않았다.

`passwd`와 `profile`은 해당 Lv0 백업에 없어서 `not found`가 나왔다. 나중에 `cp /etc/p* /xfs`로 원본에 추가해도 기존 백업 파일에 자동 반영되지 않는다. `cp`에서 `-r` 없이 디렉터리를 복사하면 디렉터리를 생략한다는 메시지가 나온다.

## 5. Vim 저장 권한 문제

`/etc/hosts` 저장 시 `E212: Can't open file for writing`이 발생했다. 이후 프롬프트가 `student@ubuntu`인 것을 확인했다. 파일 읽기와 쓰기 권한은 다르므로 `cat` 성공만으로 저장 권한이 있다는 뜻은 아니다.

수정 내용 임시 저장:

```vim
:w /tmp/hosts.new
```

기존 임시 파일이 있어 `E13`이 나왔고, 해당 파일을 덮어써도 되는 상황에서 다음을 실행해 `10L, 249B written`을 확인했다.

```vim
:w! /tmp/hosts.new
:q!
```

관리자 권한으로 반영:

```bash
sudo cp /tmp/hosts.new /etc/hosts
cat /etc/hosts
```

다음부터는 `sudo vi /etc/hosts`로 열고 `Esc → :wq → Enter`로 저장 종료한다. `:wq!`만으로 관리자 권한을 얻을 수는 없다. root에서도 실패하면 읽기 전용 마운트, 파일 속성, 용량·아이노드 등을 확인해야 한다. 이번 `df -h` 출력은 39GB 여유 공간을 보였다.

## 6. rsync 원격 복사

```bash
rsync -azvh /xfs s1:/bk
```

| 항목 | 의미 |
|---|---|
| `-a` | 재귀 복사와 주요 속성 보존을 묶은 archive 모드 |
| `-z` | 전송 데이터 압축 |
| `-v` | 상세 출력 |
| `-h` | 읽기 쉬운 용량 표시 |
| `s1` | 상대 컴퓨터의 호스트 이름 |

계정을 생략했으므로 현재 사용자와 같은 `root`로 상대 서버에 접속했다. `root@s1's password:`는 상대 서버 root 비밀번호를 요구한다. 첫 접속에는 서버의 SSH 호스트 키 신뢰 확인이 나타났다.

한 번은 연결이 끊겨 code 255가 발생했지만, 이후 인증과 전송이 성공했다. 최초 실패의 정확한 원인은 로그만으로 확정할 수 없다. 최종 출력에는 `xfs/f1`부터 `xfs/protocols`까지 파일 목록이 표시됐다. 원본 `/xfs` 뒤에 `/`가 없으므로 목적지는 `/bk/xfs`이다.

```bash
rsync -av /xfs/ /bk/  # 원본 안의 내용 복사
rsync -av /xfs  /bk/  # 원본 디렉터리 자체 복사
```

기본 rsync는 원본에서 삭제한 파일을 목적지에서 자동 삭제하지 않으며, 별도 설계 없이 과거 버전을 보존하는 백업도 아니다.

## 7. rsyslog 원격 로그 실습

Rocky에서 `/etc/rsyslog.conf`, Ubuntu에서 `/etc/rsyslog.conf`와 `/etc/rsyslog.d/50-default.conf`를 편집했다. 수정 후의 설정 내용은 기록에 없으므로 정확한 전달 규칙과 UDP/TCP 선택은 확인되지 않았다.

```bash
systemctl restart rsyslog
logger -p local0.notice "This is a test log msg 3"
logger -p local0.notice "This is a test log msg 4"
logger -p local0.notice "This is a test log msg 5"
```

위 메시지는 실제 실습의 곡선형 따옴표를 일반 큰따옴표로 정리한 예시다. `local0`는 로그 분류(facility), `notice`는 심각도다.

Ubuntu에서 확인:

```bash
tail -f /var/log/local0.log
```

`rocky10 root[...]`가 포함된 테스트 메시지 3, 4, 5가 기록된 것을 확인했다. `tail -f` 종료는 Ctrl+C이며 Ctrl+Z는 일시 중지다. 서비스 재시작 도중 Ctrl+Z를 누른 기록도 있으므로 작업 완료와 일시 중지를 구분한다.

오타: `rsyslog.comf`가 아니라 `rsyslog.conf`이다. 없는 이름으로 Vim을 열면 빈 새 파일 화면이 나온다.

## 8. journald 임시·영구 저장

```bash
mkdir -m 2775 /var/log/journal
chown root:systemd-journal /var/log/journal
systemctl restart systemd-journald
journalctl --flush
ls -l /var/log/journal/
ls -l /run/log/journal
```

- `/run/log/journal`: 휘발성 저장 위치.
- `/var/log/journal`: 영구 저장 위치.
- `2775`의 `2`: setgid. 새 항목의 그룹 상속에 사용된다.
- 영구 저장 가능 상태에서 `--flush`는 런타임 저널을 영구 저장소로 옮기도록 요청한다.

`/var/log/journal` 아래 machine ID 디렉터리가 생기고 `/run/log/journal`은 비어 있는 것을 확인했다. 이후 실습에서 영구 저널 디렉터리를 삭제하고 서비스를 재시작하자 `/run/log/journal`에 다시 디렉터리가 생겼다. 이는 `Storage=auto` 동작과 일치하지만 설정 파일 자체는 확인하지 않았다. 영구 저널 디렉터리 삭제는 기존 로그도 삭제하는 작업이다.

## 9. 디렉터리 권한과 삭제 기록

```bash
cd /bk
mkdir -m 1777 files
```

`1777`은 누구나 쓰기 가능한 권한에 sticky bit를 더한다. 다른 사용자가 만든 파일의 삭제·이름 변경은 소유자, 디렉터리 소유자, 특권 사용자 등으로 제한된다.

앞서 실행한 `rm -f /bk/*`에서는 일반 백업 파일들이 삭제되고, 디렉터리 `/bk/xfs`는 디렉터리라는 오류와 함께 남았다. 실제 삭제 명령이므로 다시 실행할 절차로 사용하지 않는다.

## 10. 방화벽 조회

Ubuntu:

```bash
ufw status
```

`ufw stuatus`는 오타로 문법 오류가 발생했다. 정상 명령의 상태 출력은 기록에 없다.

Rocky:

```bash
firewall-cmd --list-all
firewall-cmd --list-all-zones
firewall-cmd --get-default-zone
```

| 확인 항목 | 출력 결과 |
|---|---|
| 기본 영역 | `public` |
| public 인터페이스 | `ens160` |
| public 허용 서비스 | `cockpit`, `dhcpv6-client`, `ssh` |
| 직접 추가된 ports 항목 | 비어 있음 |
| docker 영역 | `docker0`에 연결되어 active |

`ports`가 비어 있어도 `services`로 허용된 통신은 존재한다. `firewalld-cmd`와 `--llist-all`은 각각 `firewall-cmd`, `--list-all`의 오타였다. `/etc/logrotate.d`에서 실행했지만 이 부분은 방화벽 조회 기록이며 logrotate 설정 변경 기록은 없다.

## 참고 문서

- [Rocky Linux: 시스템 시작](https://docs.rockylinux.org/ko/books/admin_guide/10-boot/)
- [systemd 타깃 관리](https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/10/html/using_systemd_unit_files_to_customize_and_optimize_your_system/booting-into-a-target-system-state)
- [xfsdump 매뉴얼](https://man7.org/linux/man-pages/man8/xfsdump.8.html)
- [Plymouth](https://wiki.freedesktop.org/www/Software/Plymouth/)

