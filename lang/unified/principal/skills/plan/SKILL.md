---
id: skill-plan
version: 1.0.0
---

# Plan — 계획 절차

How to turn an assignment into grains.
assignment를 grain으로 바꾸는 절차.

This skill is injected alongside `agents/planner.md`.
The agent defines who you are. This defines how you work.
If you encounter uncertainty at any step, go to "When to Signal" before proceeding.
이 스킬은 `agents/planner.md`와 함께 주입된다.
에이전트가 당신이 누구인지 정의한다. 이것은 어떻게 일하는지를 정의한다.
어떤 단계에서든 불확실하면, 진행 전에 "When to Signal"로 가라.

---

## Step 1. Gather — 수집

Read before you think.
생각하기 전에 읽어라.

- **Assignment**: Read the assignment in full. Identify the goal, constraints, and success criteria.
  assignment를 전부 읽어라. 목표, 제약, 성공 기준을 식별하라.
- **Context**: Read `context/overview.md` and `context/architecture.md`. Know what this project is and how it is built.
  If `context/architecture.md` is DRAFT or absent, explore the codebase directly to understand the structure.
  `context/overview.md`와 `context/architecture.md`를 읽어라. 이 프로젝트가 무엇이고 어떻게 만들어졌는지 파악하라.
  `context/architecture.md`가 DRAFT이거나 없으면, 코드베이스를 직접 탐색하여 구조를 파악하라.
- **Boundaries**: Read `context/boundaries.md`. Know what not to do.
  `context/boundaries.md`를 읽어라. 하지 말아야 할 것을 파악하라.
- **Project atlas**: If `$PROJECT_ATLAS_PATH` env is set, read every file under it before planning:
  - `timeline.md` — chronological index of prior delivered jobs (one line each, with link to that job's `plan.md`).
  - `architecture.md` — cumulative architectural decisions across delivered jobs.
  - `decisions.md` — cumulative trade-offs, rejected alternatives, deferred follow-ups.
  - `code-analysis/graph.json` and `code-analysis/components.md` (when present) — structural code map.
  These files are the project's "big picture". The new plan must stay consistent with them.
  For deeper detail on a specific past job, follow `timeline.md`'s link into that job's `plan.md`.
  `$PROJECT_ATLAS_PATH` env가 설정되어 있으면, 계획 전에 그 경로 아래 파일들을 모두 읽어라:
  - `timeline.md` — 이전에 납품된 잡들의 시간순 인덱스 (한 줄/잡, 해당 잡 `plan.md` 링크 포함).
  - `architecture.md` — 납품 잡 전체에 걸친 누적 아키텍처 결정.
  - `decisions.md` — 누적된 트레이드오프, 기각된 대안, 보류된 후속.
  - `code-analysis/graph.json` 와 `code-analysis/components.md` (있을 시) — 구조적 코드 맵.
  이 파일들이 이 프로젝트의 "큰 그림"이다. 새 plan은 이 위에서 일관성 있게 그려야 한다.
  특정 과거 잡의 상세는 `timeline.md`의 링크를 따라 그 잡의 `plan.md`로 drill-in 하라.
- **Static analysis**: If `.x-ray/` or equivalent exists, read `summary.md` and `graph.json` first. They reflect the actual code structure more accurately than documentation. Use them over `architecture.md` when they conflict.
  `.x-ray/` 또는 동등한 것이 있으면 `summary.md`와 `graph.json`을 먼저 읽어라. 문서보다 실제 코드 구조를 더 정확히 반영한다. 충돌 시 문서보다 우선하라.
  If no analysis exists, explore the codebase directly. Static analysis first, LLM exploration last.
  분석 결과가 없으면 코드베이스를 직접 탐색하라. 정적 분석 우선, LLM 탐색 후순위.
- **Prior decisions**: Read `context/decisions/` for decisions relevant to this assignment.
  `context/decisions/`에서 이 assignment와 관련된 결정을 읽어라.
- **`--context`**: If additional references are provided, read them.
  추가 레퍼런스가 제공되면 읽어라.

---

## Step 2. Assess — 판단

Decide complexity before decomposing.
분해 전에 복잡도를 판단하라.

- **Simple**: Single concern. Single session. No human decision needed. No ambiguity.
  → 1 grain. Skip to Step 4.
  단일 관심사. 단일 세션. 인간 결정 불필요. 모호함 없음.
  → grain 1개. Step 4로 건너뛰어라.

- **Complex**: Affects more than one abstraction boundary, requires cross-cutting changes, or needs human decisions.
  → Proceed to Step 3.
  둘 이상의 추상화 경계에 영향, 횡단적 변경 필요, 또는 인간 결정 필요.
  → Step 3으로 진행하라.

- **Unplannable**: Goals undefined. Success criteria missing. Requirements contradict.
  → Signal what must be resolved before planning can begin. Do not plan.
  목표 미정의. 성공 기준 누락. 요구사항 모순.
  → 계획을 시작하기 전에 해소해야 할 것을 신호하라. 계획하지 마라.

---

## Quality Amplification — 품질 증폭

This section activates only when the assignment contains the `[QUALITY AMPLIFICATION]` marker.
이 섹션은 assignment에 `[QUALITY AMPLIFICATION]` 마커가 포함되어 있을 때만 발동한다.

If the marker is absent, skip this section entirely and proceed to Decompose.
마커가 없으면 이 섹션 전체를 건너뛰고 Decompose로 진행하라.

When active, assess what would make the result excellent — not just correct — before decomposing.
발동 시, 분해 전에 결과물이 "정확한 것"이 아니라 "훌륭한 것"이 되려면 무엇이 필요한지 판단하라.

### Calibration — 수위 조절

Assess the assignment and apply the appropriate level:
assignment를 판단하여 적절한 수준을 적용하라:

- **Low**: Internal tools, backend APIs, infrastructure.
  Well-crafted code with good edge-case handling.
  **Low**: 내부 도구, 백엔드 API, 인프라.
  엣지 케이스가 잘 처리된 깔끔한 코드.

- **Medium**: Team-facing UI, dashboards, internal tools with users.
  Consistent design, basic polish.
  **Medium**: 팀 대면 UI, 대시보드, 사용자가 있는 내부 도구.
  일관된 디자인, 기본적인 폴리시.

- **High**: Public-facing products, demos, portfolio projects, open-ended assignments.
  Exceptional aesthetic sense. Critics give a standing ovation.
  Visual details: gradients, micro-interactions, transitions — balance of simplicity and brilliance.
  Research the best existing implementations and surpass them.
  **High**: 대중 공개 프로덕트, 데모, 포트폴리오, open-ended 과제.
  천부적 미적 감각. 평단이 기립박수.
  시각적 디테일: 그래디언트, 마이크로 인터랙션, 트랜지션 — 단순함과 화려함의 밸런스.
  동종 최고 수준의 구현을 조사하고, 그 수준을 넘겨라.

Short, open-ended assignment → lean toward High.
Detailed technical specs → lean toward Low.
User-facing output → raise the level. Internal infrastructure → lower it.
짧고 open-ended인 assignment → High 쪽으로.
상세한 기술 스펙 → Low 쪽으로.
사용자 대면 결과물 → 수준을 올려라. 내부 인프라 → 낮춰라.

### Encoding quality into grains — grain에 품질 내장

Embed quality criteria into each grain's DoneWhen.
각 grain의 DoneWhen에 품질 기준을 내장하라.

BAD: "Board renders correctly"
GOOD: "Board renders with smooth piece movement, ghost piece preview, and visual feedback for line clears"

Never write "animations — can be added later" in OutOfScope. Quality is now, not later.
Out of scope에 "animations — 나중에"를 쓰지 마라. 품질은 지금이다. 나중이 아니다.

---

## Step 3. Decompose — 분해

Split along natural fault lines.
자연스러운 결함선을 따라 쪼개라.

1. **Identify concerns**. List the distinct things the assignment asks for.
   **관심사를 식별하라.** assignment가 요구하는 별개의 것들을 나열하라.
2. **Map to boundaries**. Each concern should align with an abstraction boundary in `context/architecture.md`. Check whether a concern fits within one module or crosses modules. Cross-cutting concerns need explicit handling — either their own grain or clear instructions within each affected grain.
   **경계에 매핑하라.** 각 관심사가 `context/architecture.md`의 추상화 경계와 정렬되어야 한다. 관심사가 하나의 모듈 안에 들어가는지 모듈을 횡단하는지 확인하라. 횡단적 관심사는 명시적 처리가 필요하다 — 자체 grain으로 만들거나, 영향받는 각 grain 안에 명확한 지시를 넣어라.
3. **Find interaction points**. Where does a human need to decide? Those are grain boundaries. Not mid-grain pauses.
   **인터랙션 포인트를 찾아라.** 인간이 결정해야 하는 곳은? 그곳이 grain 경계다. grain 중간 멈춤이 아니다.
4. **Define each grain**. Per `agents/planner.md` Grain Design: what to do, what is out of scope, abstraction boundary, affected files, definition of done.
   **각 grain을 정의하라.** `agents/planner.md` Grain Design에 따라: 할 일, 범위 밖, 추상화 경계, 영향받을 파일, 완료 기준.
5. **Order grains**. Maximize independence. If a dependency is unavoidable, make it explicit. Put the most uncertain grain first — learn early, adjust the rest. The suggested execution order must work for serial execution.
   **grain 순서를 정하라.** 독립성을 최대화하라. 의존이 불가피하면 명시하라. 가장 불확실한 grain을 먼저 배치하라 — 일찍 배우고 나머지를 조정하라. 제안 실행 순서는 직렬 실행에서 작동해야 한다.

---

## Step 4. Write the Plan — 계획 작성

Output to `context/runs/{session-id}/plan.md`:
`context/runs/{session-id}/plan.md`에 출력:

```
# Plan

## Assignment summary
One paragraph. What was asked and why.

## Grains

### grain-1: [title]
- **Do**: ...
- **Out of scope**: ...
- **Boundary**: ...
- **Files**: ...
- **Done when**: ...
- **Complexity**: S | M | L
- **interact_before**: true | false
- **Depends on**: (none) | grain-N

(repeat per grain)

## Execution order
1. grain-1
2. grain-2
...
```

---

## Grain Quality Criteria — grain 품질 기준

Each grain must satisfy the following criteria when written.
각 grain 작성 시 아래 기준을 만족해야 한다.

### Do field — Do 필드

- Minimum 20 characters. Concrete and actionable.
  최소 20자 이상의 구체적, 실행 가능한 설명.
- Start with a verb ("Add...", "Refactor...", "Create...").
  동사로 시작 ("Add...", "Refactor...", "Create...").
- BAD: "Error handling" → GOOD: "Add error wrapping to HTTP handlers in `internal/api/handler.go`"
  BAD: "에러 핸들링" → GOOD: "internal/api/handler.go의 HTTP 핸들러에 error wrapping 추가"

### DoneWhen field — DoneWhen 필드

- Minimum 15 characters. Must include mechanically verifiable conditions.
  최소 15자 이상의 검증 가능한 완료 기준. 기계적 검증 가능 조건 포함.
- Use the form "X works" or "X passes."
  "~가 동작한다" 또는 "~를 통과한다" 형태.
- BAD: "Works well" → GOOD: "`go test ./internal/api/...` passes, `/health` endpoint returns 200"
  BAD: "잘 동작함" → GOOD: "`go test ./internal/api/...` 통과, `/health` 엔드포인트가 200 반환"

### Files field — Files 필드

- List file paths expected to change (minimum 1).
  변경이 예상되는 파일 경로를 명시 (최소 1개).
- Lets the implementer know where to work before starting.
  implementer가 어디서 작업해야 하는지 사전 파악 가능.

### Complexity judgment — 복잡도 판단

- **S**: 1-2 files, minimal logic change, no new patterns.
  파일 1-2개, 로직 변경 최소, 새 패턴 없음.
- **M**: 2-5 files, implementation within existing patterns.
  파일 2-5개, 기존 패턴 내 구현.
- **L**: 5+ files, new patterns or architectural changes.
  파일 5개 이상, 새 패턴/아키텍처 변경 포함.
- When in doubt, round up (S → M is safer than M → S).
  판단이 애매하면 한 단계 올려잡는다 (S보다 M이 안전).

---

## When to Signal — 신호할 때

Signal when you lack information to make a sound plan.
건전한 계획을 세우기에 정보가 부족하면 신호하라.

Triggers:
트리거:

- **Ambiguous goal**: The assignment can be interpreted in more than one valid way.
  **모호한 목표**: assignment가 둘 이상의 유효한 방식으로 해석될 수 있다.
- **Missing constraint**: A decision is needed that the assignment does not cover.
  **누락된 제약**: assignment가 다루지 않는 결정이 필요하다.
- **Conflicting inputs**: `--plan`, `context/`, or `--context` contain contradictions.
  **충돌하는 입력**: `--plan`, `context/`, 또는 `--context`에 모순이 있다.
- **Scope too large**: The assignment cannot be completed within a reasonable grain count. Clarify scope or split the assignment itself.
  **범위 과대**: assignment가 합리적인 grain 수 내에서 완료될 수 없다. 범위를 명확히 하거나 assignment 자체를 쪼개라.

When you signal, include:
신호할 때 포함하라:

1. What you know so far.
   지금까지 파악한 것.
2. What is missing or unclear.
   누락되거나 불명확한 것.
3. Options you see, with trade-offs.
   보이는 선택지와 트레이드오프.

Use the signal format specified by the execution context.
If none specified, ask the human directly.
실행 맥락이 지정한 신호 형식을 사용하라.
지정되지 않았으면 인간에게 직접 물어라.
