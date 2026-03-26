---
id: skill-implement
version: 1.0.0
---

# Implement

How to turn a grain into working code.

This skill is injected alongside `agents/implementer.md`.
The agent defines who you are. This defines how you work.
If you encounter uncertainty at any step, go to "When to Signal" before proceeding.

---

## Step 1. Prepare

Read before you write.

- **Grain definition**: Read the grain in full. Know what to do, what is out of scope, affected files, and definition of done.
- **Engineering standards**: Read `engineering.md`. This is non-negotiable.
- **Boundaries**: Read `context/boundaries.md`. Know what not to do.
- **Architecture**: Read `context/architecture.md`. Know the technical structure and stack.
- **Conventions and traps**: Read `learning/before-you-start/`. Know what others learned the hard way.
- **Static analysis**: If `.x-ray/` or equivalent exists, read the analysis for modules this grain touches. Actual code structure over documentation when they conflict.
  If no analysis exists, use available static analysis tools before LLM exploration.
- **Prior decisions**: Read `context/decisions/` for decisions relevant to this grain.

---

## Scope Guard (check before every code change)

- Only perform work specified in the grain's Do field.
- Never modify anything listed in OutOfScope.
- Respect constraints stated in Boundary.
- Do not add extra refactoring "for better code."
- Write test code only when the grain explicitly requests it.
- Verify with `git diff --stat` that changed files match the grain's Files list.

---

## Step 2. Implement

Test first. Build incrementally.

1. **Write a failing test** for the grain's definition of done. If tests are not feasible for this grain, document why and proceed.
2. **Write the minimum code** to make the test pass.
3. **Refactor** only within the grain's scope. Do not refactor surrounding code.
4. **Run affected tests** after each meaningful change. Do not accumulate untested changes. Run the full suite in Step 5 before declaring done.

Stay within the grain's scope. Unrelated issues discovered along the way go to `context/backlog.md`, not into your code.

---

## Step 3. Handle Errors

Errors are information. Act on them, do not hide them.

**Build failure:**
- Read the error. Fix the cause. Do not suppress warnings to make the build green.
- If the cause is outside the grain's scope, signal (see "When to Signal").

**Test failure:**
- A failing test you wrote means your code is wrong. Fix the code, not the test.
- If the test fails because it calls a real external service, fix the test — replace the real call with a mock adapter. Do not modify production code to make an environment-dependent test pass.
- A pre-existing test failing means your change broke something. Understand why before changing anything.
- If the affected code has no tests, write characterization tests before modifying it. Know what the code does now before changing what it does.
- If a test is genuinely wrong (testing outdated behavior), fix the test and record the decision in `context/decisions/`.

**Dependency conflict:**
- Do not force-resolve. Understand the conflict. If resolution requires a decision beyond the grain's scope, signal (see "When to Signal").

**Repeated failure (same root cause after 3 attempts):**
- Stop. You are likely misunderstanding the problem. Signal (see "When to Signal") with the error, what you tried, and why it did not work.

---

## Step 4. Record

Record as you go. Not at the end.

- **Decisions**: When you choose between two valid approaches, that is a decision. Record it in `context/decisions/` before continuing — not after. If you chose A over B, record why.
- **Backlog**: Unrelated issues, tech debt, improvements out of scope → `context/backlog.md`.

---

## Step 5. Verify

Self-check before declaring done.

These are the grain-level checks derived from `ai-protocol.md` and `engineering.md`:

- Build passes.
- Full test suite passes.
- Lint passes.
- No boundary violations.
- Grain scope respected — no additions beyond what was asked.
- Decisions recorded.
- DoneWhen verified: each DoneWhen condition in the grain checked one by one.
- File scope verified: `git diff --stat` confirms changed files match the grain's Files list.
- Imports clean: newly added imports are organized and no unused imports remain.

---

## When to Signal

Signal when you cannot proceed safely within the grain's scope.

Triggers:

- **Grain scope wrong**: The grain definition does not match what the code actually needs. Stop immediately.
- **Grain scope insufficient**: The grain can be done but needs slightly more than defined. Signal before expanding.
- **External error**: Build, test, or dependency failure caused by something outside the grain.
- **Ambiguous requirement**: The grain's definition of done can be interpreted in more than one way.
- **Repeated failure**: Same root cause after 3 fix attempts.

When you signal, include:

1. What you have done so far (working state).
2. What blocked you.
3. What you recommend, if you have an opinion.

### How to Signal

Call `AskUserQuestion`. Your process will be terminated immediately upon the call.

**Before calling:**

1. Save all file changes to disk.
2. Ensure the codebase is in a compilable state if possible.
3. Do not signal mid-edit. Complete the edit and save first.
4. Formulate a clear, specific question. Include:
   - What you have done so far (progress summary).
   - What blocked you (specific issue).
   - Your recommendation, if any (with reasoning).

**For choices** — provide 2-4 concrete options with descriptions.

**For open-ended input** — ask a specific, answerable question.

### After Resume

When you are restarted after signaling, your prompt will contain:

- `## Previous Agent Session (interrupted for interaction)` — with your partial output, the question, and the human's answer.
- Your file changes are preserved in the worktree (uncommitted).

When this context is present:

1. Read the injected context. Understand what you did before and what the human answered.
2. Verify your prior file changes still exist (`ls`, `cat`, or read the relevant files).
3. Continue from the interruption point. Do not start over.
4. Apply the human's answer to resolve the blocking issue.
