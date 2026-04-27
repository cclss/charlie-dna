---
id: index
load: always
version: 1.0.0
---

# INDEX — 진입점

This is the map. Use it.
이것이 지도다. 쓰라.

Every file has a purpose. Every file has a time.
모든 파일에는 목적이 있다. 모든 파일에는 때가 있다.

---

## Loading — 무엇을 언제

**Always — load with this file (항상 — 이 파일과 함께 로드):**
- `ai-protocol.md` — Rules for AI. 범위, 불확실성 대응, 완료 정의.

**Before plan stage (계획 단계 전):**
- If `$PROJECT_ATLAS_PATH` env is set, read its `timeline.md`, `architecture.md`,
  and `decisions.md`. These are the project's cumulative big picture across all
  prior delivered jobs. Skill `skills/plan/SKILL.md` Step 1 covers the details.
  `$PROJECT_ATLAS_PATH` env가 설정되어 있으면 그 아래 `timeline.md`,
  `architecture.md`, `decisions.md`를 먼저 읽어라. 이전에 납품된 모든 잡의
  누적된 큰 그림이다. 상세는 `skills/plan/SKILL.md` Step 1에 있다.

**Before writing code (코드 작성 전):**
- `engineering.md` — Engineering standards. 테스트, 격리, 게이트, 결정 기록.

**Before security-sensitive work (보안 관련 작업 전):**
- `security.md` — When work touches authentication, authorization, cryptography,
  external APIs, user data, secrets, or system boundaries.
  인증, 인가, 암호화, 외부 API, 사용자 데이터, 시크릿, 시스템 경계에 닿을 때.

**Before handoff (인수인계 전):**
- `collaboration.md` — Commits, PRs, handoff, knowledge recording.
  커밋, PR, 핸드오프, 지식 기록.

**When needed (필요 시):**
- `philosophy.md` — When you need to understand the "why" behind the rules.
  규칙 뒤의 "왜"를 이해해야 할 때.

**By role — the execution context assigns your role (역할별 — 실행 맥락이 역할을 지정한다):**
- `skills/plan/SKILL.md` — Planning. 계획 시.
- `skills/implement/SKILL.md` — Implementation. 구현 시.
- `skills/review/SKILL.md` — Review. 검증 시.
- `skills/handoff/SKILL.md` — Session end. 세션 종료 시.
- `skills/onboard/SKILL.md` — Project onboarding. 온보딩 시. One-time.

---

## Principles at a Glance — 원칙 요약

Section titles are the tenets. The summary lives here. The detail lives in each file.
섹션 제목이 곧 테넷이다. 요약은 여기에 산다. 상세는 각 파일에 산다.

### philosophy.md — 개발 철학
1. Discipline Is Freedom, Discipline Is Speed
2. Human Oversight Is a Feature
3. Question the Premise
4. Document First, Code Second
5. Convention Over Configuration
6. Compose Small Things
7. Earn Complexity
8. Standards Outlive Vendors
9. Write Everything Down
10. Engineering, Not Vibes

### ai-protocol.md — AI 행동 규약
1. Understand First
2. Scope
3. Immutability
4. Uncertainty and Risk
5. Definition of Done
6. Continuity

### engineering.md — 공학 기준
1. Analyze Before You Explore
2. Test Drives Design
3. One Change, One Purpose
4. Errors Are Information
5. Isolate What Varies
6. Gates, Not Suggestions
7. Decisions Are Artifacts

### collaboration.md — 협업 계약
1. Commits Tell the Story
2. The Pull Request Is the Deliverable
3. Handoff Before Exit
4. Knowledge Compounds
5. Onboarding Is a First-Class Concern
6. Suggest, Don't Sneak

### security.md — 보안 원칙
1. Secrets Are Not Code
2. Trust Nothing External
3. Least Privilege
4. Authentication and Authorization Are Separate
5. Protect Data at Every Stage
6. Dependencies Are Attack Surface
7. Fail Secure

---

## Boundaries — 경계

`principal/`, `agents/`, `skills/` are read-only. AI does not modify them.
`principal/`, `agents/`, `skills/`는 읽기 전용이다. AI는 수정하지 않는다.

`override/` is human-only. When override/ contains a file with the same name
as a principal/ file, override content appends as additional instructions.
Override wins on conflict.
`override/`는 인간 전용이다. override/에 principal/ 파일과 같은 이름의
파일이 있으면 추가 지시로 붙는다. 충돌 시 override 우선.
