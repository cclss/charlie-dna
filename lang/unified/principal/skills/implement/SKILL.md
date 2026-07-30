---
id: skill-implement
version: 1.0.0
---

# Implement — 구현 절차

How to turn a grain into working code.
grain을 작동하는 코드로 바꾸는 절차.

This skill is injected alongside `agents/implementer.md`.
The agent defines who you are. This defines how you work.
If you encounter uncertainty at any step, go to "When to Signal" before proceeding.
이 스킬은 `agents/implementer.md`와 함께 주입된다.
에이전트가 당신이 누구인지 정의한다. 이것은 어떻게 일하는지를 정의한다.
어떤 단계에서든 불확실하면, 진행 전에 "When to Signal"로 가라.

---

## Step 1. Prepare — 준비

Read before you write.
쓰기 전에 읽어라.

- **Grain definition**: Read the grain in full. Know what to do, what is out of scope, affected files, and definition of done.
  grain 정의를 전부 읽어라. 할 일, 범위 밖, 영향받을 파일, 완료 기준을 파악하라.
- **Engineering standards**: Read `engineering.md`. This is non-negotiable.
  `engineering.md`를 읽어라. 협상 불가.
- **Boundaries**: Read `context/boundaries.md`. Know what not to do.
  `context/boundaries.md`를 읽어라. 하지 말아야 할 것을 파악하라.
  If the system prompt already states the file is DRAFT or empty, do not Read it again.
  시스템 프롬프트에서 이미 해당 파일이 DRAFT이거나 비어있다고 알려주면, 다시 Read하지 마라.
- **Architecture**: Read `context/architecture.md`. Know the technical structure and stack.
  `context/architecture.md`를 읽어라. 기술 구조와 스택을 파악하라.
  If the system prompt already states the file is DRAFT or empty, do not Read it again.
  시스템 프롬프트에서 이미 해당 파일이 DRAFT이거나 비어있다고 알려주면, 다시 Read하지 마라.
- **Conventions and traps**: Read `learning/before-you-start/`. Know what others learned the hard way.
  `learning/before-you-start/`를 읽어라. 남들이 어렵게 배운 것을 파악하라.
  If the system prompt already states the file is DRAFT or empty, do not Read it again.
  시스템 프롬프트에서 이미 해당 파일이 DRAFT이거나 비어있다고 알려주면, 다시 Read하지 마라.
- **Static analysis**: If `.x-ray/` or equivalent exists, read the analysis for modules this grain touches. Actual code structure over documentation when they conflict.
  `.x-ray/` 또는 동등한 것이 있으면 이 grain이 건드리는 모듈의 분석을 읽어라. 충돌 시 문서보다 실제 코드 구조를 우선하라.
  If no analysis exists, use available static analysis tools before LLM exploration.
  분석 결과가 없으면 LLM 탐색 전에 가용한 정적 분석 도구를 사용하라.
- **Prior decisions**: Read `context/decisions/` for decisions relevant to this grain.
  `context/decisions/`에서 이 grain과 관련된 결정을 읽어라.

---

## Tool Preference — 도구 우선순위

When implementing a grain, prefer dedicated tools over Bash.
grain 구현 시, Bash보다 전용 도구를 우선하라.

- **File search**: Glob first. Bash `find` only for complex conditions.
  **파일 검색**: Glob 우선. Bash `find`는 복잡한 조건에서만.
- **Content search**: Grep first. Bash `grep` only when piping is needed.
  **내용 검색**: Grep 우선. Bash `grep`은 파이핑이 필요할 때만.
- **File reading**: Read first. Not `cat`, `head`, `tail` via Bash.
  **파일 읽기**: Read 우선. Bash의 `cat`, `head`, `tail` 사용 금지.

Bash is fine for: build, test, git, package managers, server startup.
Bash 자유 사용: 빌드, 테스트, git, 패키지 매니저, 서버 기동.

This is a preference, not a ban. Use Bash when the dedicated tool cannot do what you need.
우선순위이지 금지가 아니다. 전용 도구로 안 되면 Bash를 써라.

---

## Read/Write Efficiency — 읽기/쓰기 효율

- Read the entire file once when modifying it. Do not read 50 lines at a time.
  수정할 파일은 전체를 한 번에 읽어라. 50줄씩 나눠 읽지 마라.
- Batch related edits into a single Edit call. Seven edits of 40-character differences is wasteful.
  관련 편집을 한 번의 Edit 호출로 모아라. 40자 차이를 7번 Edit하는 것은 낭비다.
- Do not Read the same file more than twice within a grain unless you modified it between reads.
  grain 내에서 같은 파일을 두 번 이상 Read하지 마라 — 중간에 수정한 경우 제외.
- For new files, use a single Write call with complete content.
  새 파일은 Write 한 번으로 전체 내용을 작성하라.

---

## Scope Guard — 범위 보호 (check before every code change / 모든 코드 변경 전 확인)

- Only perform work specified in the grain's Do field.
  grain의 Do 필드에 명시된 작업만 수행한다.
- Never modify anything listed in OutOfScope.
  OutOfScope에 명시된 것은 절대 수정하지 않는다.
- Respect constraints stated in Boundary.
  Boundary에 명시된 제약을 준수한다.
- Do not add extra refactoring "for better code."
  "더 나은 코드를 위해" 추가 리팩토링을 하지 않는다.
- Write test code per Step 2 Phase 1, based on DoneWhen. Do not write additional tests unrelated to DoneWhen.
  테스트 코드는 Step 2 Phase 1에 따라 DoneWhen 기반으로 작성한다. DoneWhen과 무관한 추가 테스트를 작성하지 마라.
- **E2E/browser automation test prohibition.** Do not install, write, or run Playwright, Cypress, Selenium, or Puppeteer. Even if DoneWhen mentions 'e2e', substitute with unit tests. This is a global prohibition, not scope protection.
  **E2E/브라우저 자동화 테스트 절대 금지.** Playwright, Cypress, Selenium, Puppeteer를 설치, 작성, 실행하지 않는다. DoneWhen에 'e2e'가 명시되어 있더라도 단위 테스트로 대체하라. 이것은 범위 보호가 아니라 전역 금지다.
- Verify with `git diff --stat` that changed files match the grain's Files list.
  `git diff --stat`으로 변경 파일이 grain의 Files 목록과 일치하는지 확인한다.

---

## Quality Standard — 품질 기준

This grain is your only chance to implement this part. There is no polish pass afterward.
이 grain이 이 부분을 구현할 유일한 기회다. 이후에 polish pass는 없다.

Aim for portfolio-quality, not homework-quality.
숙제 수준이 아닌 포트폴리오 수준을 목표로 하라.

---

## Scope vs Quality — 범위 vs 품질

Execute the grain's Do field brilliantly. Do not add anything not in Do.
grain의 Do 필드를 훌륭하게 수행하라. Do에 없는 것은 추가하지 마라.

"Brilliant" means brilliant within scope, not expanding scope.
"훌륭함"은 범위 안에서의 훌륭함이지, 범위를 넓히는 것이 아니다.

- "Render the board" → making the rendering beautiful is within scope. Adding a Hold feature is not.
  "보드를 렌더링하라" → 렌더링을 아름답게 하는 건 범위 안이다. Hold 기능을 추가하는 건 아니다.
- If DoneWhen does not mention it, do not add it. That is scope creep.
  DoneWhen에 언급되지 않은 것을 추가하면 범위 이탈이다.

---

## Step 2. Implement — 구현

Design tests first, then implement. Keep the two phases separate.
테스트를 먼저 설계하고, 그다음 구현하라. 두 단계를 분리하라.

### Phase 1 — Write Tests / 테스트 작성

Design tests from the grain's DoneWhen criteria. If tests are not feasible for this grain, document why and proceed to Phase 2.
grain의 DoneWhen 기준으로 테스트를 설계하라. 이 grain에 테스트가 불가능하면 이유를 기록하고 Phase 2로 진행하라.

- Write tests based on DoneWhen only. Do not consider implementation approach.
  DoneWhen만 보고 테스트를 작성하라. 구현 방법을 고려하지 마라.
- Verify at the public API/interface level. Do not write tests that depend on internal implementation details.
  공개 API/인터페이스 수준에서 검증하라. 내부 구현 상세에 의존하는 테스트를 쓰지 마라.
- Write all tests this grain needs at once. Do not cycle through write-one-test / confirm-fail / write-code loops.
  이 grain에 필요한 테스트를 전부 작성하라. 하나씩 쓰고 실패를 확인하는 사이클을 돌지 마라.
- Use mock adapters for external service integrations.
  외부 서비스 연동이 필요한 곳은 모의 어댑터를 사용하라.

### Phase 2 — Implement / 구현

Make Phase 1's tests pass. / Phase 1의 테스트를 통과시켜라.

1. Read existing code, then write your implementation.
   기존 코드를 읽고, 구현을 작성하라.
2. Run tests after the implementation is complete. Do not run tests after every change — run once per logical unit completion.
   구현이 완성되면 테스트를 돌려라. 변경마다 테스트를 돌리지 마라 — 논리적 단위 완성 후 1회 실행하라.
3. If tests fail, fix the implementation and run again.
   실패하면 구현을 수정하고 다시 돌려라.
4. Refactor only within the grain's scope. Do not refactor surrounding code.
   grain 범위 안에서만 리팩터하라. 주변 코드를 리팩터하지 마라.

### Baseline Measurement / 베이스라인 측정

Before starting implementation, run tests for affected packages and their direct dependents (1-hop) once. Tests that already fail at this point are pre-existing failures. They are not your responsibility — record them in `context/backlog.md` and exclude from pass criteria.
구현 시작 전에 영향받는 패키지와 직접 의존 패키지(1-hop)의 테스트를 1회 실행하라. 이 시점에 이미 실패하는 테스트는 pre-existing failure다. 네 책임이 아니다 — `context/backlog.md`에 기록하고 pass 기준에서 제외하라.

### Test Modification Rules / 테스트 수정 규칙

- **Tests you wrote in this grain**: Fixing setup, teardown, imports, type alignment is allowed. However, do not change the assertion's intent — changing assertion values, deleting test cases, and relaxing verification conditions are prohibited. Record the reason in the handoff summary when modifying.
  **이 grain에서 작성한 테스트**: setup, teardown, import, 타입 맞춤 등 메커니즘 수정은 허용한다. 단, assertion의 의도를 변경하지 마라 — assertion 값 변경, 테스트 케이스 삭제, 검증 조건 완화는 금지다.
- **Pre-existing tests**: Do not modify. If pre-existing tests break, your implementation is wrong. Fix your implementation.
  **기존 테스트**: 수정하지 마라. 기존 테스트가 깨지면 네 구현이 잘못된 것이다. 구현을 수정하라.
- **If a pre-existing test is genuinely wrong** (testing outdated behavior): Fix the test and record the decision in `context/decisions/`.
  **기존 테스트가 진짜 틀린 경우**: 테스트를 고치고 결정을 `context/decisions/`에 기록하라.

Stay within the grain's scope. Unrelated issues discovered along the way go to `context/backlog.md`, not into your code.
grain의 범위 안에 머물러라. 도중에 발견한 관련 없는 이슈는 코드가 아니라 `context/backlog.md`로 보내라.

---

## Step 3. Handle Errors — 에러 대응

Errors are information. Act on them, do not hide them.
에러는 정보다. 대응하라, 숨기지 마라.

**Build failure:**
빌드 실패:
- Read the error. Fix the cause. Do not suppress warnings to make the build green.
  에러를 읽어라. 원인을 고쳐라. 빌드를 통과시키려고 경고를 억제하지 마라.
- If the cause is outside the grain's scope, signal (see "When to Signal").
  원인이 grain 범위 밖이면 신호하라 ("When to Signal" 참조).

**Test failure:**
테스트 실패:
- A failing test you wrote means your code is wrong. Fix the code, not the test. Do not change the assertion's intent.
  네가 작성한 테스트가 실패하면 코드가 틀린 것이다. 테스트가 아니라 코드를 고쳐라. 테스트의 assertion 의도를 바꾸지 마라.
- If the test fails because it calls a real external service, fix the test — replace the real call with a mock adapter. This is a mechanism fix, not an assertion intent change.
  테스트가 실제 외부 서비스 호출 때문에 실패하면, 테스트를 고쳐라 — 실제 호출을 모의 어댑터로 교체하라. 이것은 assertion 의도 변경이 아니라 메커니즘 수정이다.
- A pre-existing test failing means your change broke something. Do not modify the pre-existing test — fix your implementation.
  기존 테스트가 실패하면 네 변경이 뭔가를 깨뜨린 것이다. 기존 테스트를 수정하지 말고, 네 구현을 수정하라.
- Pre-existing failures (tests that already failed in the baseline) are not your responsibility. Record in `context/backlog.md` and move on.
  pre-existing failure (베이스라인에서 이미 실패한 테스트)는 네 책임이 아니다. `context/backlog.md`에 기록하고 넘어가라.
- If the affected code has no tests, write characterization tests before modifying it. Know what the code does now before changing what it does.
  영향받는 코드에 테스트가 없으면, 수정 전에 특성 테스트를 작성하라. 코드가 지금 무엇을 하는지 알고 나서 바꿔라.
- If a test is genuinely wrong (testing outdated behavior), fix the test and record the decision in `context/decisions/`.
  테스트가 진짜 틀린 거면 (오래된 동작을 테스트), 테스트를 고치고 결정을 `context/decisions/`에 기록하라.

**Dependency conflict:**
의존성 충돌:
- Do not force-resolve. Understand the conflict. If resolution requires a decision beyond the grain's scope, signal (see "When to Signal").
  강제로 해소하지 마라. 충돌을 이해하라. 해소에 grain 범위를 넘는 결정이 필요하면 신호하라 ("When to Signal" 참조).

**Repeated failure (same root cause after 3 attempts):**
반복 실패 (동일 근본 원인 3회 시도 후):
- Stop. You are likely misunderstanding the problem. Signal (see "When to Signal") with the error, what you tried, and why it did not work.
  멈춰라. 문제를 잘못 이해하고 있을 가능성이 높다. 신호하라 ("When to Signal" 참조) — 에러, 시도한 것, 왜 안 됐는지를 포함하여.

---

## Step 4. Record — 기록

Record as you go. Not at the end.
진행하면서 기록하라. 끝에 몰아서 하지 마라.

- **Decisions**: When you choose between two valid approaches, that is a decision. Record it in `context/decisions/` before continuing — not after. If you chose A over B, record why.
  두 유효한 접근 중 하나를 택하면, 그것이 결정이다. 계속하기 전에 `context/decisions/`에 기록하라 — 나중이 아니라 지금. A 대신 B를 택했으면 이유를 기록하라.
  Record only architecturally significant decisions (coordinate systems, API contracts, data flow patterns).
  아키텍처적으로 중요한 결정만 기록하라 (좌표계, API 계약, 데이터 흐름 패턴).
  Implementation details (error handling strategy, cell value representation) belong in code comments, not decision files.
  구현 상세 (에러 핸들링 전략, 셀 값 표현)는 결정 파일이 아니라 코드 주석에 둔다.
  Maximum one decision record per grain. Zero if no significant decision was made.
  grain당 최대 1개 결정 기록. 중요한 결정이 없었으면 0개.
- **Backlog**: Unrelated issues, tech debt, improvements out of scope → `context/backlog.md`.
  관련 없는 이슈, 기술 부채, 범위 밖 개선 → `context/backlog.md`.

---

## Step 5. Verify — 검증

Self-check before declaring done.
완료를 선언하기 전에 스스로 확인하라.

These are the grain-level checks derived from `ai-protocol.md` and `engineering.md`:
`ai-protocol.md`와 `engineering.md`에서 도출된 grain 수준 체크:

- Build passes.
  빌드 통과.
- Full test suite passes (excluding pre-existing failures).
  전체 테스트 스위트 통과 (pre-existing failure 제외).
- Lint passes.
  린트 통과.
- No boundary violations.
  경계 위반 없음.
- Grain scope respected — no additions beyond what was asked.
  grain 범위 준수 — 요청된 것 이상의 추가 없음.
- Decisions recorded.
  결정 기록 완료.
- DoneWhen verified: each DoneWhen condition in the grain checked one by one.
  DoneWhen 검증: grain의 DoneWhen 조건을 하나씩 확인.
- File scope verified: `git diff --stat` confirms changed files match the grain's Files list.
  파일 범위 검증: `git diff --stat`으로 변경 파일이 grain Files 목록과 일치하는지 확인.
- Imports clean: newly added imports are organized and no unused imports remain.
  import 정리: 새로 추가한 import가 정리되었고 미사용 import가 남아있지 않음.

---

## Step 6. Handoff Summary — 인계 요약

Leave a structured summary for the next grain after Verify passes.
Verify 통과 후, 다음 grain을 위한 구조화된 요약을 남겨라.

This summary is automatically injected into the next grain's context by the orchestrator.
이 요약은 오케스트레이터가 다음 grain의 맥락에 자동으로 주입한다.

Output this at the end of your response, after any other output:
다른 모든 출력 뒤, 응답의 마지막에 이것을 출력하라:

~~~~
### Files Changed
- {filename} (+N lines) — {what changed / 변경 내용}

### Key Interfaces Added
- {functionName}({params}) → {returnType} — {description / 설명}
- {CONSTANT_NAME}: {description / 설명}

### Decisions
- {decision} — {reason / 이유}
~~~~

Rules:
규칙:

- Maximum 3-5 bullet points per section. Focus on what the next grain needs.
  섹션당 최대 3-5개 불릿. 다음 grain이 필요한 것에 집중하라.
- Do not repeat the grain's Do/DoneWhen — the next grain already has those.
  grain의 Do/DoneWhen을 반복하지 마라 — 다음 grain이 이미 가지고 있다.
- Omit Decisions section if no significant decisions were made.
  중요한 결정이 없었으면 Decisions 섹션을 생략하라.

---

## Step 7. Code Analysis Emit — 코드 분석 emit

After the Handoff Summary, emit a single machine-readable snapshot of what *this grain*
changed. The orchestrator's atlas pipeline (M13) parses this hint to enrich the project's
cumulative code-analysis without re-deriving everything from tree-sitter alone.
Handoff Summary 다음에, **이 grain이 무엇을 바꿨는지** 한 번 emit 한다. 오케스트레이터의
atlas 파이프라인 (M13) 이 이 힌트를 파싱하여 프로젝트 누적 코드 분석을 풍부하게 한다 —
tree-sitter 만으로 전부 재유도하지 않도록.

Output exactly one fenced code block with the language tag `analysis-emit`. Skip the
section entirely when this grain made zero file changes (empty payloads add noise).
정확히 한 개의 펜스 코드 블록을 `analysis-emit` 언어 태그와 함께 출력하라. 이 grain이
파일을 전혀 바꾸지 않았으면 섹션 자체를 생략하라 (빈 payload 는 노이즈).

~~~analysis-emit
{
  "files_changed": ["path/to/a.go", "path/to/b.ts"],
  "functions_added": ["FuncA", "FuncB"],
  "functions_modified": ["FuncC"],
  "imports_added": ["lodash", "fmt"],
  "imports_removed": []
}
~~~

Rules:
규칙:

- Paths are repo-relative with forward slashes.
  경로는 repo 기준 상대 경로, forward slash.
- Function names as declared (no signatures, no class qualifier unless that is the
  declared name).
  함수 이름은 선언 그대로 (시그니처 X, 클래스 한정자 X — 단, 선언 이름이 그렇다면 유지).
- Imports are the imported module/package identity, not the local alias.
  import 는 가져온 모듈/패키지 정체성. 로컬 별칭이 아니다.
- This is a best-effort hint, not a contract — the orchestrator falls back to a fresh
  tree-sitter scan on parse failure or absence. Better to skip the block than emit a
  malformed one.
  베스트 에포트 힌트이지 계약이 아니다 — 파싱 실패나 부재 시 오케스트레이터가 새로운
  tree-sitter 스캔으로 폴백한다. 잘못된 블록보다 생략이 낫다.

---

## When to Signal — 신호할 때

Signal when you cannot proceed safely within the grain's scope.
grain 범위 안에서 안전하게 진행할 수 없으면 신호하라.

Triggers:
트리거:

- **Grain scope wrong**: The grain definition does not match what the code actually needs. Stop immediately.
  **grain 범위 오류**: grain 정의가 코드가 실제로 필요로 하는 것과 맞지 않다. 즉시 멈춰라.
- **Grain scope insufficient**: The grain can be done but needs slightly more than defined. Signal before expanding.
  **grain 범위 부족**: grain은 완료 가능하지만 정의된 것보다 약간 더 필요하다. 확장 전에 신호하라.
- **External error**: Build, test, or dependency failure caused by something outside the grain.
  **외부 에러**: grain 밖의 원인에 의한 빌드, 테스트, 또는 의존성 실패.
- **Ambiguous requirement**: The grain's definition of done can be interpreted in more than one way.
  **모호한 요구사항**: grain의 완료 기준이 둘 이상의 방식으로 해석될 수 있다.
- **Repeated failure**: Same root cause after 3 fix attempts.
  **반복 실패**: 3회 수정 시도 후에도 동일 근본 원인.

When you signal, include:
신호할 때 포함하라:

1. What you have done so far (working state).
   지금까지 한 것 (작동 상태).
2. What blocked you.
   막힌 것.
3. What you recommend, if you have an opinion.
   의견이 있다면 추천하는 것.

### How to Signal — 신호 방법

Call `AskUserQuestion`. Your process will be terminated immediately upon the call.
`AskUserQuestion`을 호출하라. 호출 즉시 프로세스가 종료된다.

**Before calling:**
호출 전:

1. Save all file changes to disk.
   모든 파일 변경을 디스크에 저장하라.
2. Ensure the codebase is in a compilable state if possible.
   가능하면 코드베이스가 컴파일되는 상태를 확보하라.
3. Do not signal mid-edit. Complete the edit and save first.
   편집 도중에 신호하지 마라. 편집을 마치고 저장한 후 신호하라.
4. Formulate a clear, specific question. Include:
   명확하고 구체적인 질문을 구성하라. 포함할 것:
   - What you have done so far (progress summary).
     지금까지 한 것 (진행 요약).
   - What blocked you (specific issue).
     막힌 것 (구체적 문제).
   - Your recommendation, if any (with reasoning).
     추천사항이 있다면 (근거와 함께).

**For choices** — provide 2-4 concrete options with descriptions.
**선택지가 있을 때** — 2-4개 구체적 선택지를 설명과 함께 제공하라.

**For open-ended input** — ask a specific, answerable question.
**자유 입력이 필요할 때** — 구체적이고 답변 가능한 질문을 하라.

### After Resume — 재개 후

When you are restarted after signaling, your prompt will contain:
신호 후 재시작되면 프롬프트에 다음이 포함된다:

- `## Previous Agent Session (interrupted for interaction)` — with your partial output, the question, and the human's answer.
  이전 세션의 부분 출력, 질문, 인간의 답변.
- Your file changes are preserved in the worktree (uncommitted).
  파일 변경이 워크트리에 보존됨 (커밋되지 않은 상태).

When this context is present:
이 맥락이 있을 때:

1. Read the injected context. Understand what you did before and what the human answered.
   주입된 맥락을 읽어라. 이전에 한 것과 인간이 답한 것을 파악하라.
2. Verify your prior file changes still exist (`ls`, `cat`, or read the relevant files).
   이전 파일 변경이 존재하는지 확인하라.
3. Continue from the interruption point. Do not start over.
   중단 지점에서 이어가라. 처음부터 시작하지 마라.
4. Apply the human's answer to resolve the blocking issue.
   인간의 답변을 적용하여 막힌 문제를 해결하라.
