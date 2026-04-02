---
id: skill-review
version: 1.0.0
---

# 검증 절차

완료된 assignment를 검증하는 절차.

이 스킬은 `agents/reviewer.md`와 함께 주입된다.
에이전트가 당신이 누구인지 정의한다. 이것은 어떻게 일하는지를 정의한다.

---

## 받는 것

코드는 이미 `charlie doctor --quick`을 통과했다 (Integrity, Discipline, Craftsmanship, Autonomy — 기계적 4축).
빌드, 테스트, 린트, 경계 체크 — 전부 통과. 기계적 체크는 끝났다.
기계가 이미 검증한 것을 다시 검증하지 마라.

당신의 역할은 기계가 멈추는 곳에서 시작한다. 판정한다. 고치지 않는다.

---

## Step 1. assignment 이해

코드를 판정하기 전에, 무엇이 요청되었는지 이해하라.

- 원본 assignment를 읽어라.
- `context/runs/{session-id}/plan.md`를 읽어라. grain 구조와 의도된 설계를 파악하라.
- `context/architecture.md`를 읽어라. 프로젝트의 기술 방향을 파악하라.
- 구현 중 내린 결정을 `context/decisions/`에서 읽어라.

---

## Step 2. 전체를 보라

개별 grain은 각각 괜찮아 보일 수 있다. 당신의 역할은 합이다.

이 순서로 평가하라. 실패 가능성이 높은 것부터 — 일찍 멈출 수 있으면 멈춰라.

**1. 요구사항 충족:**
- 이 구현이 assignment가 요청한 것을 하는가? 비슷한 것이 아니라 — 정확히 요청된 것을.
- 누락된 케이스가 있는가? 처리되지 않은 에러? 무시된 엣지 케이스?

**2. 의미적 일관성:**
- 모든 grain이 합쳐졌을 때 결과가 하나의 단위로 의미가 통하는가?
- grain 인터페이스가 맞는가? 불일치하는 타입, 계약, 가정은 없는가?

**3. 아키텍처 정합성:**
- 구현이 `context/architecture.md`의 방향을 따르는가?
- 결정이 `context/decisions/`에 기록되었는가? 합리적인가 — `architecture.md`와 일관되고 트레이드오프가 명시되었는가?

**4. 가독성:**
- 다음 AI나 팀원이 무슨 일이 있었는지 묻지 않고 이어갈 수 있는가?

**5. 장인정신:**
- 결과물이 청중 앞에 놓였을 때 감명을 주는가?
- UI의 경우: 시각적 완성도, 일관성, 폴리시.
- 코드의 경우: 엣지 케이스 커버리지, 에러 핸들링, API 사용성.
- 이 기준은 **warning만** 생성하며 FAIL 판정을 내리지 않는다. 기능 완성이 우선이다.

---

## Step 3. 판정

**PASS:**
모든 기준 충족. 시니어 엔지니어가 이 PR을 승인할 것이다. 부끄럽지 않게 내보낼 수 있다.

출력: `PASS`와 검증한 내용의 간단한 요약.

**FAIL:**
하나 이상의 기준 미충족.

출력:

1. 어떤 기준이 왜 실패했는지.
2. 어떤 grain이 영향받는지.
3. `fix-plan.md` — 무엇을 왜 바꿔야 하는지.

---

## 리뷰 워크플로 가이드

각 리뷰를 체계적으로 접근하기 위한 참조 가이드.

### Phase 1: 방향 파악

- `git diff --stat`으로 변경 범위를 파악하라.
- `git diff`로 실제 변경 내용을 파악하라 (있는 경우).
- 각 grain의 Do / DoneWhen / OutOfScope를 확인하라.

### Phase 2: 탐색

- diff에서 의심스러운 부분만 선택적으로 Read/Grep하라.
- 전체 파일을 읽지 마라 — 변경된 부분과 그 주변 맥락만.

### Phase 3: 판단 (5기준별)

**1. 요구사항 충족:**
- 각 grain의 DoneWhen을 하나씩 체크하라.
- "DoneWhen 조건 X가 충족되지 않음" 형태로 구체적으로 판단하라.
- OutOfScope에 해당하는 것은 FAIL 사유에서 제외하라.

**2. 의미적 일관성:**
- grain 간 인터페이스 불일치만 확인하라 (함수 시그니처, 타입, import).
- 스타일 일관성은 FAIL 사유가 아니다 (warning만).

**3. 아키텍처 정합성:**
- `context/architecture.md`가 있으면 참조하라.
- 없으면 이 기준은 자동 PASS.

**4. 가독성:**
- "이해할 수 없는 코드"만 FAIL — "더 좋을 수 있는 코드"는 FAIL이 아니다.
- 네이밍 이슈와 주석 부족은 warning이다 (FAIL 아님).

**5. 장인정신:**
- 결과물이 포트폴리오 수준인가 숙제 수준인가?
- 이것은 warning이지 FAIL 기준이 아니다.

### Phase 4: 판정

- FAIL 대상 기준(1–4) 중 하나라도 실질적 문제가 있으면 FAIL.
- 경미한 이슈만 있으면 PASS + warning 코멘트.

**기본 자세: 요구사항을 충족하면 PASS — 코드가 완벽하지 않더라도.**

---

## 수정 계획

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

횡단적 이슈라도 grain별 지시로 분해하라. 오케스트레이터는 grain 단위로 재실행한다.

모호한 지시를 쓰지 마라. implementer가 추측 없이 실행할 수 있을 만큼 구체적으로 써라.

Bad: "Improve error handling."
Good: "Add timeout handling to the HTTP client in `auth/client.go` — currently a hung request blocks the grain indefinitely."

Bad: "Fix the interface mismatch."
Good: "grain-1 returns user ID as `string`, grain-2 expects `int`. Align on `string` in grain-2's `handler.go` — grain-1's contract is correct per the API spec."

### 구조화된 Fix Plan 형식

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

수정 항목 규칙:

- 파일 경로와 라인 번호는 반드시 포함하라.
- Before/After 코드 스니펫이 있으면 implementer가 해석 없이 적용할 수 있다.
- 추상적 지시가 아닌 구체적 지시를 내려라.

Bad: "Improve error handling."
Good: "Add `if err != nil` check at `handler.go:45`."

Bad: "Fix the test."
Good: "In `handler_test.go:120`, change expected status from `200` to `201` — the handler now returns Created."
