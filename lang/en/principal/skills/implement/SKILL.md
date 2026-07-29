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
  If the system prompt already states the file is DRAFT or empty, do not Read it again.
- **Architecture**: Read `context/architecture.md`. Know the technical structure and stack.
  If the system prompt already states the file is DRAFT or empty, do not Read it again.
- **Conventions and traps**: Read `learning/before-you-start/`. Know what others learned the hard way.
  If the system prompt already states the file is DRAFT or empty, do not Read it again.
- **Static analysis**: If `.x-ray/` or equivalent exists, read the analysis for modules this grain touches. Actual code structure over documentation when they conflict.
  If no analysis exists, use available static analysis tools before LLM exploration.
- **Prior decisions**: Read `context/decisions/` for decisions relevant to this grain.

---

## Tool Preference

When implementing a grain, prefer dedicated tools over Bash.

- **File search**: Glob first. Bash `find` only for complex conditions.
- **Content search**: Grep first. Bash `grep` only when piping is needed.
- **File reading**: Read first. Not `cat`, `head`, `tail` via Bash.

Bash is fine for: build, test, git, package managers, server startup.

This is a preference, not a ban. Use Bash when the dedicated tool cannot do what you need.

---

## Read/Write Efficiency

- Read the entire file once when modifying it. Do not read 50 lines at a time.
- Batch related edits into a single Edit call. Seven edits of 40-character differences is wasteful.
- Do not Read the same file more than twice within a grain unless you modified it between reads.
- For new files, use a single Write call with complete content.

---

## Scope Guard (check before every code change)

- Only perform work specified in the grain's Do field.
- Never modify anything listed in OutOfScope.
- Respect constraints stated in Boundary.
- Do not add extra refactoring "for better code."
- Write test code per Step 2 Phase 1, based on DoneWhen. Do not write additional tests unrelated to DoneWhen.
- Verify with `git diff --stat` that changed files match the grain's Files list.

---

## Quality Standard

This grain is your only chance to implement this part. There is no polish pass afterward.

Aim for portfolio-quality, not homework-quality.

---

## Scope vs Quality

Execute the grain's Do field brilliantly. Do not add anything not in Do.

"Brilliant" means brilliant within scope, not expanding scope.

- "Render the board" → making the rendering beautiful is within scope. Adding a Hold feature is not.
- If DoneWhen does not mention it, do not add it. That is scope creep.

---

## Step 2. Implement

Design tests first, then implement. Keep the two phases separate.

### Phase 1 — Write Tests

Design tests from the grain's DoneWhen criteria. If tests are not feasible for this grain, document why and proceed to Phase 2.

- Write tests based on DoneWhen only. Do not consider implementation approach.
- Verify at the public API/interface level. Do not write tests that depend on internal implementation details (private functions, internal structures).
- Write all tests this grain needs at once. Do not cycle through write-one-test / confirm-fail / write-code loops.
- Use mock adapters for external service integrations.

### Phase 2 — Implement

Make Phase 1's tests pass.

1. Read existing code, then write your implementation.
2. Run tests after the implementation is complete. Do not run tests after every change — run once per logical unit completion.
3. If tests fail, fix the implementation and run again.
4. Refactor only within the grain's scope. Do not refactor surrounding code.

### Baseline Measurement

Before starting implementation, run tests for affected packages and their direct dependents (1-hop) once. Tests that already fail at this point are pre-existing failures. They are not your responsibility — record them in `context/backlog.md` and exclude from pass criteria. Only tests that newly fail due to your changes are your fix targets.

### Test Modification Rules

- **Tests you wrote in this grain**: Fixing setup, teardown, imports, type alignment is allowed. However, do not change the assertion's intent (what is being verified) — changing assertion values, deleting test cases, and relaxing verification conditions are prohibited. Record the reason in the handoff summary when modifying.
- **Pre-existing tests (tests that existed before this grain)**: Do not modify. If pre-existing tests break, your implementation is wrong. Fix your implementation.
- **If a pre-existing test is genuinely wrong** (testing outdated behavior): Fix the test and record the decision in `context/decisions/`.

Stay within the grain's scope. Unrelated issues discovered along the way go to `context/backlog.md`, not into your code.

---

## Step 3. Handle Errors

Errors are information. Act on them, do not hide them.

**Build failure:**
- Read the error. Fix the cause. Do not suppress warnings to make the build green.
- If the cause is outside the grain's scope, signal (see "When to Signal").

**Test failure:**
- A failing test you wrote means your code is wrong. Fix the code, not the test. Do not change the assertion's intent.
- If the test fails because it calls a real external service, fix the test — replace the real call with a mock adapter. This is a mechanism fix, not an assertion intent change.
- A pre-existing test failing means your change broke something. Do not modify the pre-existing test — fix your implementation.
- Pre-existing failures (tests that already failed in the baseline) are not your responsibility. Record in `context/backlog.md` and move on.
- If the affected code has no tests, write characterization tests before modifying it. Know what the code does now before changing what it does.
- If a pre-existing test is genuinely wrong (testing outdated behavior), fix the test and record the decision in `context/decisions/`.

**Dependency conflict:**
- Do not force-resolve. Understand the conflict. If resolution requires a decision beyond the grain's scope, signal (see "When to Signal").

**Repeated failure (same root cause after 3 attempts):**
- Stop. You are likely misunderstanding the problem. Signal (see "When to Signal") with the error, what you tried, and why it did not work.

---

## Step 4. Record

Record as you go. Not at the end.

- **Decisions**: When you choose between two valid approaches, that is a decision. Record it in `context/decisions/` before continuing — not after. If you chose A over B, record why.
  Record only architecturally significant decisions (coordinate systems, API contracts, data flow patterns).
  Implementation details (error handling strategy, cell value representation) belong in code comments, not decision files.
  Maximum one decision record per grain. Zero if no significant decision was made.
- **Backlog**: Unrelated issues, tech debt, improvements out of scope → `context/backlog.md`.

---

## Step 5. Verify

Self-check before declaring done.

These are the grain-level checks derived from `ai-protocol.md` and `engineering.md`:

- Build passes.
- Full test suite passes (excluding pre-existing failures).
- Lint passes.
- No boundary violations.
- Grain scope respected — no additions beyond what was asked.
- Decisions recorded.
- DoneWhen verified: each DoneWhen condition in the grain checked one by one.
- File scope verified: `git diff --stat` confirms changed files match the grain's Files list.
- Imports clean: newly added imports are organized and no unused imports remain.

---

## Step 6. Handoff Summary

Leave a structured summary for the next grain after Verify passes.

This summary is automatically injected into the next grain's context by the orchestrator.

Output this at the end of your response, after any other output:

~~~~
### Files Changed
- {filename} (+N lines) — {what changed}

### Key Interfaces Added
- {functionName}({params}) → {returnType} — {description}
- {CONSTANT_NAME}: {description}

### Decisions
- {decision} — {reason}
~~~~

Rules:

- Maximum 3-5 bullet points per section. Focus on what the next grain needs.
- Do not repeat the grain's Do/DoneWhen — the next grain already has those.
- Omit Decisions section if no significant decisions were made.

---

## Step 7. Code Analysis Emit

After the Handoff Summary, emit a single machine-readable snapshot of what *this grain*
changed. The orchestrator's atlas pipeline (M13) parses this hint to enrich the project's
cumulative code-analysis without re-deriving everything from tree-sitter alone.

Output exactly one fenced code block with the language tag `analysis-emit`. Skip the
section entirely when this grain made zero file changes (empty payloads add noise).

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

- Paths are repo-relative with forward slashes.
- Function names as declared (no signatures, no class qualifier unless that is the
  declared name).
- Imports are the imported module/package identity, not the local alias.
- This is a best-effort hint, not a contract — the orchestrator falls back to a fresh
  tree-sitter scan on parse failure or absence. Better to skip the block than emit a
  malformed one.

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
