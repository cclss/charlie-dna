---
id: ai-protocol
load: always
version: 1.0.0
---

# AI Protocol — AI 행동 규약

Rules for AI operating in this environment.
이 환경에서 AI가 따르는 규칙.

---

## 1. Understand First — 먼저 이해하라

**Read before you write. Understand the problem before writing code.**
**쓰기 전에 읽어라. 코드를 쓰기 전에 문제를 이해하라.**

- Read available documentation and context before exploring code.
  코드를 탐색하기 전에 가용한 문서와 맥락을 읽어라.
- Verify your understanding of the requirement before implementation.
  구현 전에 요구사항에 대한 이해를 확인하라.

---

## 2. Scope — 범위

**Do not exceed the assignment.**
**과제의 범위를 벗어나지 마라.**

- Execute what was assigned. Nothing more.
  할당된 것을 수행하라. 그 이상은 없다.
- Do not refactor unrequested code.
  요청되지 않은 코드를 리팩터하지 마라.
- Do not add unrequested features.
  요청되지 않은 기능을 추가하지 마라.

---

## 3. Immutability — 수정 불가 영역

**These are read-only. No exceptions.**
**읽기 전용이다. 예외 없다.**

- `principal/` — immutable. 불변.
- `agents/` — immutable. 불변.
- `skills/` — immutable. 불변.
- `override/` — human-only. 인간 전용.

---

## 4. Uncertainty and Risk — 불확실하거나 위험할 때

**Do not guess. Signal for human input and stop.**
**추측하지 마라. 인간의 입력을 요청하고 멈춰라.**

Signal using the format specified by the execution context.
If no format is specified, ask the human directly.
실행 맥락이 지정한 형식으로 신호하라.
형식이 지정되지 않았으면 인간에게 직접 물어라.

Triggers:
트리거:

- Ambiguous requirement. 모호한 요구사항.
- Insufficient context. 맥락 부족.
- Multiple valid approaches, no clear winner.
  유효한 접근법이 여럿, 승자 없음.
- Decision affects architecture. 아키텍처 영향.
- Hard to undo. 되돌리기 어려움.
- Action poses risk, even if you are confident.
  확신이 있더라도 행동이 위험을 수반한다.

---

## 5. Definition of Done — 완료의 정의

**Self-check before declaring done.**
**완료를 선언하기 전에 스스로 확인하라.**

- Build succeeds. 빌드 성공.
- Tests pass. 테스트 통과.
- Lint passes. 린트 통과.
- No boundary violations. boundaries 위반 없음.
- Scope not exceeded. 범위 이탈 없음.

---

## 6. Continuity — 연속성

**The next session must continue where this one stopped.**
**다음 세션은 이 세션이 멈춘 곳에서 이어가야 한다.**

- Record decisions in context/decisions/ as they happen.
  결정은 발생 시점에 context/decisions/에 기록하라.
- At session end, handoff/SKILL.md defines what to record.
  세션 종료 시 handoff/SKILL.md가 기록 대상을 정의한다.
