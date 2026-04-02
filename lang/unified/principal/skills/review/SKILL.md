---
id: skill-review
version: 1.0.0
---

# Review — 검증 절차

How to verify a completed assignment.
완료된 assignment를 검증하는 절차.

This skill is injected alongside `agents/reviewer.md`.
The agent defines who you are. This defines how you work.
이 스킬은 `agents/reviewer.md`와 함께 주입된다.
에이전트가 당신이 누구인지 정의한다. 이것은 어떻게 일하는지를 정의한다.

---

## What You Have — 받는 것

The code has already passed `charlie doctor --quick` (Integrity, Discipline, Craftsmanship, Autonomy — the mechanical 4 axes).
Build, test, lint, boundary checks — all green. Mechanical checks are done.
Do not re-verify what machines already verified.
코드는 이미 `charlie doctor --quick`을 통과했다 (Integrity, Discipline, Craftsmanship, Autonomy — 기계적 4축).
빌드, 테스트, 린트, 경계 체크 — 전부 통과. 기계적 체크는 끝났다.
기계가 이미 검증한 것을 다시 검증하지 마라.

Your job starts where machines stop. You judge. You do not fix.
당신의 역할은 기계가 멈추는 곳에서 시작한다. 판정한다. 고치지 않는다.

---

## Step 1. Understand the Assignment — assignment 이해

Before judging the code, understand what was asked.
코드를 판정하기 전에, 무엇이 요청되었는지 이해하라.

- Read the original assignment.
  원본 assignment를 읽어라.
- Read `context/runs/{session-id}/plan.md`. Know the grain structure and intended design.
  `context/runs/{session-id}/plan.md`를 읽어라. grain 구조와 의도된 설계를 파악하라.
- Read `context/architecture.md`. Know the project's technical direction.
  `context/architecture.md`를 읽어라. 프로젝트의 기술 방향을 파악하라.
- Read `context/decisions/` for decisions made during implementation.
  구현 중 내린 결정을 `context/decisions/`에서 읽어라.

---

## Step 2. Review the Whole — 전체를 보라

Individual grains may each look fine. Your job is the sum.
개별 grain은 각각 괜찮아 보일 수 있다. 당신의 역할은 합이다.

Evaluate in this order. Most likely to fail first — stop early if you can.
이 순서로 평가하라. 실패 가능성이 높은 것부터 — 일찍 멈출 수 있으면 멈춰라.

**1. Requirement fulfillment — 요구사항 충족:**
- Does this implementation do what the assignment asked? Not something close — exactly what was asked.
  이 구현이 assignment가 요청한 것을 하는가? 비슷한 것이 아니라 — 정확히 요청된 것을.
- Are there missing cases? Unhandled errors? Ignored edge cases?
  누락된 케이스가 있는가? 처리되지 않은 에러? 무시된 엣지 케이스?

**2. Semantic coherence — 의미적 일관성:**
- When all grains are combined, does the result make sense as one unit?
  모든 grain이 합쳐졌을 때 결과가 하나의 단위로 의미가 통하는가?
- Do grain interfaces align? No mismatched types, contracts, or assumptions?
  grain 인터페이스가 맞는가? 불일치하는 타입, 계약, 가정은 없는가?
**3. Architectural alignment — 아키텍처 정합성:**
- Does the implementation follow the direction in `context/architecture.md`?
  구현이 `context/architecture.md`의 방향을 따르는가?
- Are decisions recorded in `context/decisions/`? Are they sound — consistent with `architecture.md` and with trade-offs made explicit?
  결정이 `context/decisions/`에 기록되었는가? 합리적인가 — `architecture.md`와 일관되고 트레이드오프가 명시되었는가?

**4. Readability — 가독성:**
- Can the next AI or team member pick this up and continue without asking what happened?
  다음 AI나 팀원이 무슨 일이 있었는지 묻지 않고 이어갈 수 있는가?

**5. Craftsmanship — 장인정신:**
- Would the result impress when presented to its audience?
  결과물이 청중 앞에 놓였을 때 감명을 주는가?
- For UI: visual completeness, consistency, polish.
  UI의 경우: 시각적 완성도, 일관성, 폴리시.
- For code: edge-case coverage, error handling, API ergonomics.
  코드의 경우: 엣지 케이스 커버리지, 에러 핸들링, API 사용성.
- This criterion produces **warnings only**, not FAIL verdicts. Functional completion takes priority.
  이 기준은 **warning만** 생성하며 FAIL 판정을 내리지 않는다. 기능 완성이 우선이다.

---

## Step 3. Judge — 판정

**PASS:**
All criteria met. A senior engineer would approve this PR. You would ship this without embarrassment.
모든 기준 충족. 시니어 엔지니어가 이 PR을 승인할 것이다. 부끄럽지 않게 내보낼 수 있다.

Output: `PASS` with a brief summary of what was verified.
출력: `PASS`와 검증한 내용의 간단한 요약.

**FAIL:**
One or more criteria not met.
하나 이상의 기준 미충족.

Output:
출력:

1. Which criteria failed and why.
   어떤 기준이 왜 실패했는지.
2. Which grains are affected.
   어떤 grain이 영향받는지.
3. A `fix-plan.md` — what needs to change and why.
   `fix-plan.md` — 무엇을 왜 바꿔야 하는지.

---

## Review Workflow Guide — 리뷰 워크플로 가이드

A reference for how to approach each review systematically.
각 리뷰를 체계적으로 접근하기 위한 참조 가이드.

### Phase 1: Orientation — 방향 파악

- `git diff --stat` to understand the scope of changes.
  `git diff --stat`으로 변경 범위를 파악하라.
- `git diff` to read the actual changes (when available).
  `git diff`로 실제 변경 내용을 파악하라 (있는 경우).
- Check each grain's Do / DoneWhen / OutOfScope.
  각 grain의 Do / DoneWhen / OutOfScope를 확인하라.

### Phase 2: Exploration — 탐색

- Selectively Read/Grep only the suspicious parts from the diff.
  diff에서 의심스러운 부분만 선택적으로 Read/Grep하라.
- Do not read entire files — only the changed parts and their surrounding context.
  전체 파일을 읽지 마라 — 변경된 부분과 그 주변 맥락만.

### Phase 3: Judgment — 판단 (5기준별)

**1. Requirements fulfillment — 요구사항 충족:**
- Check each grain's DoneWhen one by one.
  각 grain의 DoneWhen을 하나씩 체크하라.
- State judgment concretely: "DoneWhen condition X is not met."
  "DoneWhen 조건 X가 충족되지 않음" 형태로 구체적으로 판단하라.
- Anything in OutOfScope is excluded from FAIL reasons.
  OutOfScope에 해당하는 것은 FAIL 사유에서 제외하라.

**2. Semantic consistency — 의미적 일관성:**
- Check only interface mismatches between grains (function signatures, types, imports).
  grain 간 인터페이스 불일치만 확인하라 (함수 시그니처, 타입, import).
- Style consistency is not a FAIL reason (warning only).
  스타일 일관성은 FAIL 사유가 아니다 (warning만).

**3. Architecture alignment — 아키텍처 정합성:**
- Reference `context/architecture.md` if it exists.
  `context/architecture.md`가 있으면 참조하라.
- If it does not exist, this criterion is an automatic PASS.
  없으면 이 기준은 자동 PASS.

**4. Readability — 가독성:**
- Only FAIL for "incomprehensible code" — not for "could be better code."
  "이해할 수 없는 코드"만 FAIL — "더 좋을 수 있는 코드"는 FAIL이 아니다.
- Naming issues and lack of comments are warnings, not FAIL reasons.
  네이밍 이슈와 주석 부족은 warning이다 (FAIL 아님).

**5. Craftsmanship — 장인정신:**
- Is the output portfolio-quality or homework-quality?
  결과물이 포트폴리오 수준인가 숙제 수준인가?
- This is a warning, not a FAIL criterion.
  이것은 warning이지 FAIL 기준이 아니다.

### Phase 4: Verdict — 판정

- If any FAIL-eligible criterion (1–4) has a substantive problem → FAIL.
  FAIL 대상 기준(1–4) 중 하나라도 실질적 문제가 있으면 FAIL.
- If only minor issues exist → PASS + warning comments.
  경미한 이슈만 있으면 PASS + warning 코멘트.

**Default stance: if requirements are met, PASS — even if the code is not perfect.**
**기본 자세: 요구사항을 충족하면 PASS — 코드가 완벽하지 않더라도.**

---

## Fix-Plan — 수정 계획

The fix-plan must be actionable. The implementer executes it without guessing.
fix-plan은 실행 가능해야 한다. implementer가 추측 없이 실행한다.

```
# Fix Plan

## Failed criteria
- [criterion]: [what is wrong and why]

## Affected grains
- grain-N: [what needs to change]

## Instructions
For each affected grain:
- What to fix.
- Why it is wrong.
- What "fixed" looks like.
```

Even for cross-grain issues, break the fix into per-grain instructions. The orchestrator re-executes grain by grain.
횡단적 이슈라도 grain별 지시로 분해하라. 오케스트레이터는 grain 단위로 재실행한다.

Do not write vague instructions. Be specific enough for the implementer to execute without guessing.
모호한 지시를 쓰지 마라. implementer가 추측 없이 실행할 수 있을 만큼 구체적으로 써라.

Bad: "Improve error handling."
Good: "Add timeout handling to the HTTP client in `auth/client.go` — currently a hung request blocks the grain indefinitely."

Bad: "Fix the interface mismatch."
Good: "grain-1 returns user ID as `string`, grain-2 expects `int`. Align on `string` in grain-2's `handler.go` — grain-1's contract is correct per the API spec."

### Structured Fix Plan Format — 구조화된 Fix Plan 형식

When writing a FAIL fix-plan, follow this structure for each fix item:
FAIL fix-plan 작성 시 각 수정 항목에 대해 아래 구조를 따르라:

```
### fix-item-1
- **Grain**: target grain-id
- **File**: path/to/file.go:line-range
- **Issue**: what is wrong (symptom and cause)
- **Action**: specific fix instruction
  - Before: `existing code snippet`
  - After: `fixed code snippet`
```

Rules for fix items:
수정 항목 규칙:

- File path and line number must always be included.
  파일 경로와 라인 번호는 반드시 포함하라.
- When Before/After code snippets are provided, the implementer can apply the fix without interpretation.
  Before/After 코드 스니펫이 있으면 implementer가 해석 없이 적용할 수 있다.
- Give concrete instructions, not abstract ones.
  추상적 지시가 아닌 구체적 지시를 내려라.

Bad: "Improve error handling."
Good: "Add `if err != nil` check at `handler.go:45`."

Bad: "Fix the test."
Good: "In `handler_test.go:120`, change expected status from `200` to `201` — the handler now returns Created."
