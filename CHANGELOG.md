# CHANGELOG

---

## v0.4.0 — 2026-03-26

SKILL/Agent 파일 개선 + 다국어 분리.

### 파트 1: SKILL/Agent 파일 개선 (A3~C2)

- `principal/skills/review/SKILL.md` — Fix Plan 구조화 형식 가이드 추가 (A3). Review Workflow Guide 추가 (A4).
- `agents/reviewer.md` — 행동 규칙 섹션 추가 (A5).
- `principal/skills/plan/SKILL.md` — Grain 품질 기준 섹션 추가 (B1).
- `agents/planner.md` — 탐색 전략 가이드 추가 (B2).
- `principal/skills/implement/SKILL.md` — Scope Guard 섹션 추가 (C2). Step 5 Verify 체크리스트 강화 (C1).

### 파트 2: 다국어 분리

- `principal-en/`, `principal-ko/` — principal/ 병기 파일 11개를 영문/국문 전용으로 분리.
- `agents-en/`, `agents-ko/` — agents/ 병기 파일 3개를 영문/국문 전용으로 분리.
- 원본 `principal/`, `agents/` (병기 버전) 유지 — `--lang` 미지정 시 기본값.

---

## v0.3.0 — 2026-03-25

외부 경계 테스트에 mock adapter 규칙 추가.

- `principal/engineering.md` — §2 "Test Drives Design"에 외부 서비스 모킹 원칙 추가.
- `principal/engineering.md` — §5 "Isolate What Varies"에 테스트 시 mock adapter 사용 원칙 추가.
- `principal/skills/implement/SKILL.md` — Step 3 "Test failure"에 환경 의존적 테스트 실패 대응 규칙 추가 (죽음의 소용돌이 차단).

---

## v0.2.0 — 2026-03-23

Interaction signal protocol 추가.

- `principal/ai-protocol.md` — §4에 Signal Protocol 서브섹션 추가 (신호 시 프로세스 종료 원칙, 안정 상태 확보 규칙).
- `principal/skills/implement/SKILL.md` — "How to Signal" + "After Resume" 서브섹션 추가 (`AskUserQuestion` 라이프사이클, 재개 절차).
- `agents/implementer.md` — "Resume After Interaction" 섹션 추가 (주입 맥락 인식, 중단점 이어가기).

---

## v0.1.0 — 2026-03-09

릴리즈 워크플로우 테스트.

- `scripts/release.sh` — 릴리즈 스크립트 추가.
- `.github/workflows/release.yml` — tag push 시 GitHub Release 자동 생성.
- `CONTRIBUTING.md` — 브랜치→PR→머지→태그 워크플로우 문서.

---

## v1.0.0 — 2026-03-09

초기 안정 릴리즈.

### 구조

- `templates/` 래퍼 제거 → `principal/`, `agents/`, `context/`, `scaffold/` 플랫 구조.
- 네임스페이싱 규칙: 레포 구조와 deployed 구조의 1:1 대응.

### principal/ — 불변의 Charlie DNA

- `INDEX.md` — 진입점. 로딩 계층 6단계.
- `philosophy.md` — Elon Musk 톤. 영한 통합. CTO 선언.
- `ai-protocol.md` — 자율주행 규칙. 6섹션.
- `engineering.md` — 공학 원칙. 7섹션+Verify.
- `collaboration.md` — 협업 계약. 6섹션.
- `security.md` — 보안 원칙. 7섹션.

### principal/skills/ — 행동 정의

- `plan/SKILL.md` — assignment → grain 분해.
- `implement/SKILL.md` — grain 구현. 5 Step + When to Signal.
- `review/SKILL.md` — 최종 검증. 판정만.
- `handoff/SKILL.md` — 세션 종료. 6 Step.
- `onboard/SKILL.md` — 프로젝트 초기 구성. 4 Step + Signal.

### agents/ — Agent 역할 정의

- `planner.md` — assignment → grain 분해. model: sonnet.
- `implementer.md` — grain 구현. model: sonnet.
- `reviewer.md` — assignment 검증. model: opus.

### context/ — 프로젝트 상태 템플릿

- `overview.md`, `architecture.md`, `boundaries.md` — onboard 시 채워짐.
- `changelog.md`, `backlog.md` — 자동/수동 기록.
- `roadmap.md` — roadmap: local 모드 전용.

### scaffold/ — 프로젝트 루트에 배치되는 파일

- `AGENTS.md` — Agent CLI 진입점.
- `learning/` — before-you-start, adr, cookbook, postmortem, onboarding 템플릿.

### 제거

- `spells.md` — v1.0.0에서 제거 (defer).
