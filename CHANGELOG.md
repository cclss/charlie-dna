# CHANGELOG

---

## v1.2.0 — 2026-04-27

charlie-cloud M13 Phase E 와 짝. implementer 가 grain 끝마다 변경
파일/함수/import 를 기계가 읽을 수 있는 JSON 으로 emit 하도록 추가.
오케스트레이터의 atlas 파이프라인 (M13) 이 이 힌트를 받아 코드 분석
누적을 풍부하게 함 — tree-sitter 만으로 전부 재유도하지 않도록.

### implement/SKILL.md (3 변종 sync)
- **Step 7. Code Analysis Emit** 신규. Step 6 Handoff Summary 다음에
  `analysis-emit` 펜스 블록으로 `files_changed` / `functions_added` /
  `functions_modified` / `imports_added` / `imports_removed` 를
  내보냄. grain 이 파일 변경 없으면 섹션 자체를 생략 (빈 payload =
  노이즈).
- 베스트 에포트 힌트 — 파싱 실패/부재 시 오케스트레이터가 tree-sitter
  rescan 으로 폴백.

### dna.yaml
- version 1.1.0 → 1.2.0 (additive minor — 미출력 시 무영향).

---

## v1.1.0 — 2026-04-27

Project Atlas 인프라 통합 — charlie-cloud M12 와 짝.

### plan/SKILL.md (3 변종 sync)
- **Step 1. Gather** 에 `Project atlas` 항목 추가. `$PROJECT_ATLAS_PATH` env 가
  설정되어 있으면 plan 전에 `timeline.md` / `architecture.md` / `decisions.md` /
  `code-analysis/` 누적 컨텍스트를 읽도록 지시.
- 잡 단위 reset 으로 인한 큰 그림 망각 문제를 잡기 위한 변경. 이전 잡 상세는
  `timeline.md` 의 link 따라 drill-in.

### principal/INDEX.md (3 변종 sync)
- Loading 섹션에 `Before plan stage` 항목 추가. atlas 읽기 진입점 안내.

### dna.yaml
- version 1.0.0 → 1.1.0 (additive feature, backward-compatible — env 미설정 시 no-op).

---

## v0.5.3 — 2026-04-02

하네스 품질 개선 — implementer/planner/reviewer DNA 강화.

### implement/SKILL.md
- **Step 6. Handoff Summary**: grain 완료 후 다음 grain을 위한 구조화된 인계 요약 출력.
- **Tool Preference**: grain 구현 시 전용 도구(Glob/Grep/Read) 우선 사용 가이드.
- **Read/Write Efficiency**: 파일 읽기/쓰기 효율 규칙 (중복 Read 방지, Edit 배치).
- **Quality Standard + Scope vs Quality**: 포트폴리오 수준 품질 기준 + 범위 내 훌륭함 원칙.
- **Step 4 Record 보완**: 아키텍처적 결정만 기록, grain당 최대 1개.
- **Step 1 Prepare 보완**: 시스템 프롬프트에서 DRAFT 상태 안내 시 중복 Read 생략.

### plan/SKILL.md
- **Quality Amplification**: `[QUALITY AMPLIFICATION]` 마커 조건부 품질 증폭 섹션 (Low/Medium/High calibration).

### agents/planner.md
- **역할 격상**: "PM이 아니다. 아키텍트다" — plan 품질 기준 상향.
- **Polish Grain**: 사용자 대면 프로젝트에 마감 grain 가이드.
- **Research Phase**: open-ended assignment 시 시장 조사 단계.

### review/SKILL.md + agents/reviewer.md
- **5번째 검증 기준: Craftsmanship**: 장인정신 (warning only, FAIL 아님).
- Phase 3 Judgment 5기준으로 확장, Phase 4 Verdict "FAIL 대상 기준(1–4)" 명확화.

### 전체
- `lang/unified/`, `lang/en/`, `lang/ko/` 3개 언어 동시 적용.

---

## v0.5.2 — 2026-03-30

`lang/unified/` scaffold/context 병기화.

- `lang/unified/scaffold/` 14개 파일을 한국어 only → 영문/국문 병기로 변환.
- `lang/unified/context/` 7개 파일 동일 적용 (improvement-directive.md 포함).
- `lang/ko/`, `lang/en/` 변경 없음.

---

## v0.5.1 — 2026-03-30

**Breaking**: 디렉토리 구조 변경 — flat → `lang/` 그룹핑.

### 구조 개편

- 기존 루트의 `principal/`, `principal-ko/`, `principal-en/`, `agents/`, `agents-ko/`, `agents-en/`, `scaffold/`, `context/`를 `lang/{unified,ko,en}/` 하위로 이동.
- 각 언어 디렉토리가 동일한 4벌 구조 완비: `principal/`, `agents/`, `scaffold/`, `context/`.

### scaffold/context 다국어 추가

- `lang/en/scaffold/` — 영어 AGENTS.md, learning/ 전체 번역.
- `lang/en/context/` — 영어 context 템플릿 (overview, architecture, backlog 등).
- `lang/ko/scaffold/` — 한국어 scaffold (기존 unified에서 분리).
- `lang/ko/context/` — 한국어 context 템플릿 (기존 unified에서 분리).

### CLI 마이그레이션

- `MIGRATION-v0.5-cli.md` — charlie-cli 대응 가이드 추가.
- `--lang` 플래그가 이제 scaffold/context에도 적용됨.

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
