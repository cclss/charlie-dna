# Contributing to charlie-dna

---

## 이 저장소의 성격

charlie-dna는 순수 Markdown 저장소다.
코드 없음. 빌드 없음. 테스트 없음.
변경은 드물고 신중해야 한다 — principal/ 파일은 모든 프로젝트에 영향을 미친다.

---

## 브랜치 전략

```
master        최신 안정 버전. 직접 작업.
v1            v2.0.0 출시 시 master에서 분기. v1 유지보수용.
              (v2 시작 전까지 불필요)
```

- `master`에서 직접 작업한다. 변경 빈도가 낮으므로 develop 브랜치 불필요.
- 메이저 버전 업그레이드 시 이전 메이저의 유지보수 브랜치를 분기한다.
  예: v2.0.0 출시 → `v1` 브랜치를 v1 최종 태그에서 생성.

---

## 태그 전략

```
v1.0.0, v1.1.0, v2.0.0 ...
```

- Semver. `vX.Y.Z` 형식.
- 태그는 불변이다. 삭제하지 않는다.
- 구버전 접근의 핵심 수단이다.

---

## 버전 규칙

| 변경 유형 | 버전 | 예 |
|-----------|------|---|
| 내용 개선/수정 (파일 구조 동일) | minor | v1.0.0 → v1.1.0 |
| 파일 추가/삭제, 구조 변경 | major | v1.x.0 → v2.0.0 |
| 오타/문구 수정 (의미 변화 없음) | patch | v1.0.0 → v1.0.1 |

charlie-cli가 `charlie dna update` 시:
- minor/patch: 자동 적용 가능.
- major: 마이그레이션 가이드 필요.

---

## 릴리즈 절차

### 1. CHANGELOG.md 업데이트

새 버전 섹션을 추가한다:

```markdown
## vX.Y.Z — YYYY-MM-DD

변경 내용 기술.
```

### 2. 커밋

```bash
git add -A
git commit -m "release: vX.Y.Z — 변경 요약"
```

### 3. 릴리즈 스크립트 실행

```bash
# 검증만 (실제 태그/푸시 안 함)
./scripts/release.sh vX.Y.Z --dry-run

# 실행 (태그 + 푸시 + GitHub Release 생성)
./scripts/release.sh vX.Y.Z
```

스크립트가 하는 일:
1. 버전 형식 검증 (semver)
2. CHANGELOG.md에 해당 버전 섹션 존재 확인
3. git tag 생성
4. origin에 push (master + tags)
5. `gh release create` (CHANGELOG에서 릴리즈 노트 추출)

### 4. 확인

- GitHub Releases 페이지에서 릴리즈 확인.
- tag push 시 GitHub Action이 자동으로 Release를 생성하므로,
  스크립트의 `gh release`가 실패해도 Action이 백업으로 처리한다.

---

## 구버전 유지보수

- 구버전 태그는 영원히 유지된다.
- charlie-cli가 `config.yaml`의 `dna: v1.0.0`을 보고 해당 태그를 가져온다.
- v2 출시 후 v1에 핫픽스가 필요한 경우:
  1. `v1` 브랜치가 없으면 v1 최종 태그에서 생성.
  2. 핫픽스를 `v1` 브랜치에 커밋.
  3. 새 태그 (v1.x.y) 생성.
  4. master로의 cherry-pick은 해당 시 판단.

---

## 변경 시 주의사항

- **principal/ 변경은 모든 프로젝트에 영향을 미친다.** 신중하게.
- 파일 삭제/이름 변경은 major 버전에서만.
- YAML frontmatter의 `version` 필드를 새 버전으로 업데이트하는 것을 잊지 마라.
- CHANGELOG.md에 변경 사항을 빠짐없이 기록하라.
