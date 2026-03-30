---
id: skill-onboard
version: 1.0.0
---

# Onboard — 온보딩 절차

How to bootstrap a project's context from its masterplan.
마스터플랜으로부터 프로젝트 맥락을 부트스트랩하는 절차.

This skill runs once via `charlie onboard`. It is not repeated.
No agent identity is paired — this is a standalone setup procedure.
If you encounter uncertainty at any step, go to "When to Signal" before proceeding.
이 스킬은 `charlie onboard`를 통해 한 번 실행된다. 반복되지 않는다.
에이전트 정체성이 쌍을 이루지 않는다 — 독립된 셋업 절차다.
어떤 단계에서든 불확실하면, 진행 전에 "When to Signal"로 가라.

---

## Step 1. Read Inputs — 입력 읽기

Read everything available before generating anything.
무엇이든 생성하기 전에 가용한 모든 것을 읽어라.

- **`context/masterplan.md`** — Required. This is the source of truth for what the project is, why it exists, and what it aims to do. If this file is missing or empty, signal (see "When to Signal").
  필수. 프로젝트가 무엇이고, 왜 존재하고, 무엇을 목표로 하는지의 원천이다. 이 파일이 없거나 비어 있으면 신호하라 ("When to Signal" 참조).
- **`--context`** — Optional. Additional references provided by the human (existing docs, design specs, external resources). Read them all.
  선택. 인간이 제공한 추가 레퍼런스 (기존 문서, 설계 스펙, 외부 자료). 전부 읽어라.
- **Existing codebase** — If code already exists, explore it. If `.x-ray/` or equivalent exists, start there. The masterplan describes intent; the code describes reality. When they conflict, note the discrepancy in the generated files.
  기존 코드베이스가 있으면 탐색하라. `.x-ray/` 또는 동등한 것이 있으면 거기서 시작하라. 마스터플랜은 의도를 설명하고, 코드는 현실을 설명한다. 충돌 시 생성 파일에 차이를 기록하라.

---

## Step 2. Generate Context Files — 맥락 파일 생성

All generated files start as `STATUS: DRAFT`. Write it as the first line of each file.
모든 생성 파일은 `STATUS: DRAFT`로 시작한다. 각 파일의 첫 줄로 쓰라.

DRAFT files must not be referenced by AI as authoritative until the human confirms them.
DRAFT 파일은 인간이 확인할 때까지 AI가 권위 있는 자료로 참조해서는 안 된다.

### 2.1 `context/overview.md` — 프로젝트 개요

What the project is, in plain language. A newcomer reads this first and knows what they are working on.
프로젝트가 무엇인지, 평이한 언어로. 새 합류자가 이것을 먼저 읽고 무엇을 작업하는지 파악한다.

Include:
포함할 것:

- Project purpose and scope.
  프로젝트 목적과 범위.
- Key terminology specific to this project.
  이 프로젝트 고유의 핵심 용어.
- Current project status — what exists, what is planned, what is not started.
  현재 프로젝트 상태 — 무엇이 있고, 무엇이 계획되었고, 무엇이 미착수인지.

### 2.2 `context/architecture.md` — 기술 구조

The technical structure of the project. How it is built, not what it does.
프로젝트의 기술 구조. 무엇을 하는지가 아니라 어떻게 만들어졌는지.

Include:
포함할 것:

- Tech stack — languages, frameworks, databases, infrastructure.
  기술 스택 — 언어, 프레임워크, 데이터베이스, 인프라.
- Module/package structure and their responsibilities. Module structure defines the physical boundaries.
  모듈/패키지 구조와 각각의 책임. 모듈 구조가 물리적 경계를 정의한다.
- Key abstraction boundaries — the logical contracts between modules. Where one module ends and another begins.
  핵심 추상화 경계 — 모듈 간의 논리적 계약. 한 모듈이 끝나고 다른 모듈이 시작하는 곳.
- Data flow — how data moves through the system.
  데이터 흐름 — 데이터가 시스템을 통해 어떻게 흐르는지.
- **Abstraction level** — what is the right level of abstraction for this project? Small composable functions, layered services, or domain-driven modules? The answer differs per project. State it explicitly. Start with a reasonable default. Revise as the project evolves.
  **추상화 수준** — 이 프로젝트에 적정한 추상화 수준은? 작은 조합형 함수, 계층형 서비스, 또는 도메인 주도 모듈? 답은 프로젝트마다 다르다. 명시하라. 합리적인 기본값으로 시작하라. 프로젝트가 발전하면서 수정하라.
- Operational context — how it is deployed, where it runs, how it fails. Code architecture alone is insufficient.
  운영 맥락 — 어떻게 배포되는지, 어디서 돌아가는지, 어떻게 실패하는지. 코드 아키텍처만으로는 불충분하다.

### 2.3 `context/boundaries.md` — 금지 사항

What not to do. Constraints that apply regardless of the assignment.
하지 말아야 할 것. assignment와 무관하게 적용되는 제약.

Include:
포함할 것:

- Technologies, patterns, or approaches that are explicitly off-limits.
  명시적으로 금지된 기술, 패턴, 접근법.
- External services or APIs that must not be called or replaced.
  호출하거나 대체해서는 안 되는 외부 서비스나 API.
- Architectural decisions that are settled and must not be revisited.
  확정되어 재논의해서는 안 되는 아키텍처 결정.

If the masterplan does not specify boundaries, state: "No explicit boundaries defined. Apply engineering.md and security.md defaults."
마스터플랜이 경계를 지정하지 않으면 명시하라: "명시적 경계 미정의. engineering.md와 security.md 기본값 적용."

### 2.4 `context/roadmap.md` — 로드맵 (조건부)

Only generate this if the project uses `roadmap: local` mode (set in `config.yaml`).
프로젝트가 `roadmap: local` 모드를 사용할 때만 생성하라 (`config.yaml`에 설정).

If not applicable, skip.
해당 없으면 건너뛰어라.

---

## Step 3. Generate Onboarding Materials — 온보딩 자료 생성

These go to `learning/onboarding/`. They are the guided tour for newcomers.
`learning/onboarding/`에 배치한다. 새 합류자를 위한 안내 투어다.

### 3.1 `learning/onboarding/README.md` — 시작점

The reading order. A newcomer follows this list from top to bottom.
읽기 순서. 새 합류자가 위에서 아래로 이 목록을 따라간다.

Include:
포함할 것:

- How the `.charlie/` directory is structured and what each part does — principal/ (immutable principles), agents/ (role definitions), skills/ (procedures), context/ (project state), learning/ (accumulated knowledge), memory/ (session history).
  `.charlie/` 디렉토리 구조와 각 부분의 역할 — principal/ (불변 원칙), agents/ (역할 정의), skills/ (절차), context/ (프로젝트 상태), learning/ (축적된 지식), memory/ (세션 이력).
- The reading order per `collaboration.md` Section 5. This file is the starting point. List the remaining steps:
  `collaboration.md` 5절에 따른 읽기 순서. 이 파일이 시작점이다. 나머지 단계를 나열하라:

1. `learning/before-you-start/` — Read before touching code.
2. `context/overview.md` → `context/architecture.md` → `context/boundaries.md`
3. `learning/adr/` — Skim recent decisions.

### 3.2 `learning/onboarding/architecture-tour.md` — 아키텍처 투어

A walkthrough of the codebase for someone who has never seen it.
코드베이스를 처음 보는 사람을 위한 안내.

- Start from the entry point. Trace the main flow.
  진입점에서 시작하라. 주요 흐름을 추적하라.
- Explain the "why" behind structural choices, not just the "what."
  구조적 선택의 "무엇"뿐 아니라 "왜"를 설명하라.
- The tour is a path — what to look at first and in what order. `context/architecture.md` is the map — what is there. Reference the map for details, do not duplicate it.
  투어는 경로다 — 무엇을 먼저, 어떤 순서로 볼지. `context/architecture.md`는 지도다 — 무엇이 있는지. 상세는 지도를 참조하라, 복제하지 마라.
- If no code exists yet, describe the intended structure based on the masterplan. Mark it clearly: "Based on masterplan — not yet implemented."
  코드가 아직 없으면, 마스터플랜 기반의 의도된 구조를 설명하라. 명확히 표시하라: "마스터플랜 기반 — 아직 구현되지 않음."

---

## Step 4. Present for Review — 검토 제출

List every file you generated with a one-line summary of what it contains.
생성한 모든 파일을 한 줄 요약과 함께 나열하라.

Tell the human:
인간에게 알려라:

- All files are STATUS: DRAFT.
  모든 파일이 STATUS: DRAFT이다.
- Each file needs human review and confirmation before AI treats it as authoritative.
  AI가 권위 있는 자료로 취급하기 전에 각 파일에 인간의 검토와 확인이 필요하다.
- To confirm a file, change its status to `STATUS: CONFIRMED`.
  파일을 확인하려면 상태를 `STATUS: CONFIRMED`로 변경하라.

---

## When to Signal — 신호할 때

Signal when inputs are insufficient to generate useful context.
유용한 맥락을 생성하기에 입력이 불충분하면 신호하라.

Triggers:
트리거:

- **Missing masterplan**: `context/masterplan.md` is absent or empty. Cannot proceed.
  **마스터플랜 부재**: `context/masterplan.md`가 없거나 비어 있다. 진행 불가.
- **Ambiguous scope**: The masterplan does not make clear what the project does or what its boundaries are.
  **모호한 범위**: 마스터플랜이 프로젝트가 무엇을 하는지 또는 경계가 무엇인지 명확히 하지 않는다.
- **Contradictory inputs**: The masterplan and `--context` materials conflict.
  **모순되는 입력**: 마스터플랜과 `--context` 자료가 충돌한다.
- **Missing tech stack**: Cannot determine languages, frameworks, or infrastructure from available inputs.
  **기술 스택 부재**: 가용한 입력에서 언어, 프레임워크, 인프라를 판단할 수 없다.
- **Significant divergence**: The existing codebase contradicts the masterplan in ways that affect the generated context files. Do not silently guess which is correct — ask.
  **심각한 충돌**: 기존 코드베이스가 마스터플랜과 생성할 맥락 파일에 영향을 주는 방식으로 모순된다. 어느 쪽이 맞는지 조용히 추측하지 마라 — 물어라.

When you signal, include:
신호할 때 포함하라:

1. What you were able to determine.
   판단할 수 있었던 것.
2. What is missing.
   누락된 것.
3. What you need from the human to proceed.
   진행하기 위해 인간에게 필요한 것.

Use the signal format specified by the execution context.
If none specified, ask the human directly.
실행 맥락이 지정한 신호 형식을 사용하라.
지정되지 않았으면 인간에게 직접 물어라.
