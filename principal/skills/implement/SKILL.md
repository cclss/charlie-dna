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
- **Architecture**: Read `context/architecture.md`. Know the technical structure and stack.
  `context/architecture.md`를 읽어라. 기술 구조와 스택을 파악하라.
- **Conventions and traps**: Read `learning/before-you-start/`. Know what others learned the hard way.
  `learning/before-you-start/`를 읽어라. 남들이 어렵게 배운 것을 파악하라.
- **Static analysis**: If `.x-ray/` or equivalent exists, read the analysis for modules this grain touches. Actual code structure over documentation when they conflict.
  `.x-ray/` 또는 동등한 것이 있으면 이 grain이 건드리는 모듈의 분석을 읽어라. 충돌 시 문서보다 실제 코드 구조를 우선하라.
  If no analysis exists, use available static analysis tools before LLM exploration.
  분석 결과가 없으면 LLM 탐색 전에 가용한 정적 분석 도구를 사용하라.
- **Prior decisions**: Read `context/decisions/` for decisions relevant to this grain.
  `context/decisions/`에서 이 grain과 관련된 결정을 읽어라.

---

## Step 2. Implement — 구현

Test first. Build incrementally.
테스트 먼저. 점진적으로 구축하라.

1. **Write a failing test** for the grain's definition of done. If tests are not feasible for this grain, document why and proceed.
   grain의 완료 기준에 대한 실패하는 테스트를 작성하라. 이 grain에 테스트가 불가능하면 이유를 기록하고 진행하라.
2. **Write the minimum code** to make the test pass.
   테스트를 통과시키는 최소한의 코드를 작성하라.
3. **Refactor** only within the grain's scope. Do not refactor surrounding code.
   grain 범위 안에서만 리팩터하라. 주변 코드를 리팩터하지 마라.
4. **Run affected tests** after each meaningful change. Do not accumulate untested changes. Run the full suite in Step 5 before declaring done.
   변경마다 영향받는 테스트를 돌려라. 테스트되지 않은 변경을 쌓지 마라. 완료 선언 전에 Step 5에서 전체 스위트를 돌려라.

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
- A failing test you wrote means your code is wrong. Fix the code, not the test.
  네가 작성한 테스트가 실패하면 코드가 틀린 것이다. 테스트가 아니라 코드를 고쳐라.
- A pre-existing test failing means your change broke something. Understand why before changing anything.
  기존 테스트가 실패하면 네 변경이 뭔가를 깨뜨린 것이다. 아무것도 바꾸기 전에 왜인지 이해하라.
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
- Full test suite passes.
  전체 테스트 스위트 통과.
- Lint passes.
  린트 통과.
- No boundary violations.
  경계 위반 없음.
- Grain scope respected — no additions beyond what was asked.
  grain 범위 준수 — 요청된 것 이상의 추가 없음.
- Decisions recorded.
  결정 기록 완료.

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
3. Formulate a clear, specific question. Include:
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
