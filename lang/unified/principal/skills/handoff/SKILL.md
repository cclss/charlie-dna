---
id: skill-handoff
version: 1.0.0
---

# Handoff — 인수인계 절차

How to close a session so the next one starts clean.
세션을 마무리하여 다음 세션이 깨끗하게 시작하도록 하는 절차.

This skill is injected at session end. It runs in the current agent's context.
The agent's identity does not change. This adds a closing procedure.
이 스킬은 세션 종료 시 주입된다. 현재 에이전트의 맥락에서 실행된다.
에이전트의 정체성은 바뀌지 않는다. 마무리 절차가 추가된다.

---

## When This Runs — 실행 시점

- Session end — ai-protocol.md mandates this.
  세션 종료 — ai-protocol.md가 강제한다.
- `charlie run` completion.
  `charlie run` 완료 시.
- `/done` command (Agent CLI direct use).
  `/done` 커맨드 (Agent CLI 직접 사용 시).

If the session is ending abnormally (context exhaustion, forced termination), skip to Step 6. The session summary is the non-negotiable minimum.
세션이 비정상 종료되는 경우 (컨텍스트 소진, 강제 종료), Step 6으로 건너뛰어라. 세션 요약이 협상 불가한 최소다.

---

## Step 1. Assess What Happened — 무엇이 있었는지 파악

Before recording anything, know what is worth recording.
기록하기 전에, 기록할 가치가 있는 것을 파악하라.

- What did you complete?
  무엇을 완료했는가?
- What remains unfinished?
  무엇이 미완료인가?
- Did you make decisions that a successor would question?
  후임자가 의문을 가질 결정을 내렸는가?
- Did you discover traps, patterns, or failures worth preserving?
  보존할 가치가 있는 함정, 패턴, 실패를 발견했는가?

If nothing happened worth recording beyond the session summary — say so explicitly. "No learnings to record this session" is a valid answer. Silently skipping is not.
세션 요약 외에 기록할 만한 것이 없었다면 — 명시적으로 말하라. "이 세션에서 기록할 학습이 없다"는 유효한 답이다. 조용히 건너뛰는 것은 아니다.

---

## Step 2. Record Decisions — 결정 기록

If decisions were already recorded during implementation, verify completeness — do not re-record. This step adds what was missed and elevates decisions to ADRs where warranted.
구현 중에 이미 결정이 기록되었으면 완전성을 확인하라 — 다시 기록하지 마라. 이 단계는 누락된 것을 추가하고, 필요한 결정을 ADR로 격상한다.

Two places. Different purposes. Do not mix them.
두 곳. 목적이 다르다. 혼합하지 마라.

- **`context/decisions/`** — Fact tracking. What was decided and its current status. Living document — update as status changes. Every decision goes here.
  사실 기록. 무엇이 결정되었고 현재 상태가 무엇인지. 살아있는 문서 — 상태 변경 시 업데이트. 모든 결정이 여기로 간다.

- **`learning/adr/`** — Lesson archive. Why it was decided and what we learned. Immutable once ACCEPTED. Not every decision becomes an ADR — only those where the reasoning or trade-offs teach something. Lifecycle: PROPOSED → ACCEPTED → DEPRECATED → SUPERSEDED.
  교훈 아카이브. 왜 결정했고 무엇을 배웠는지. ACCEPTED 후 불변. 모든 결정이 ADR이 되지는 않는다 — 추론이나 트레이드오프가 무언가를 가르치는 것만. 생명주기: PROPOSED → ACCEPTED → DEPRECATED → SUPERSEDED.

ADR format: title, status, context, decision, trade-offs, consequences.
ADR filename: next sequence number + decision summary (e.g., `0003-use-facade-for-auth.md`).
ADR 형식: 제목, 상태, 컨텍스트, 결정, 트레이드오프, 결과.
ADR 파일명: 다음 일련번호 + 결정 요약 (예: `0003-use-facade-for-auth.md`).

Check existing PROPOSED ADRs. If this session's work resolved one, update its status to ACCEPTED.
기존 PROPOSED ADR을 확인하라. 이 세션의 작업이 하나를 해소했으면 상태를 ACCEPTED로 업데이트하라.

The test: "Would a stranger benefit from understanding *why* this decision was made?"
If yes → ADR. If the fact alone is enough → `context/decisions/` only.
When in doubt, write the ADR. A surplus of lessons is cheaper than a deficit.
판별 기준: "낯선 사람이 이 결정의 *이유*를 이해하면 도움이 되는가?"
그렇다면 → ADR. 사실만으로 충분하면 → `context/decisions/`만.
의심스러우면, ADR을 써라. 교훈의 과잉이 결핍보다 싸다.

---

## Step 3. Record Learnings — 학습 기록

Check each area. Record what applies. Skip what does not.
각 영역을 확인하라. 해당하는 것을 기록하라. 해당하지 않는 것은 건너뛰어라.

**`learning/cookbook/`** — Reusable solutions.
재사용 가능한 해결책.
- Did a reusable solution emerge? Record it: problem → solution → example → caveats.
  재사용 가능한 해결책이 나왔는가? 기록하라: 문제 → 해결책 → 예시 → 주의사항.
- Does an existing cookbook entry need updating? Update it rather than creating a new one.
  기존 쿡북 항목이 업데이트 필요한가? 새로 만들지 말고 업데이트하라.

**`learning/postmortem/`** — Failures and surprises.
실패와 예상 밖의 일.
- Did something fail or go differently than expected? Record it: what happened → why → what we learned → what to do next time.
  실패하거나 예상과 다르게 진행된 것이 있는가? 기록하라: 무슨 일 → 왜 → 배운 것 → 다음에는.
- Blame kills learning. Fix systems, not individuals.
  비난은 학습을 죽인다. 시스템을 고쳐라, 개인을 지목하지 마라.

**`learning/before-you-start/`** — Traps and conventions.
함정과 관습.
- New gotcha discovered? Add to `gotchas.md`.
  새 함정을 발견했는가? `gotchas.md`에 추가하라.
- New implicit rule emerged? Add to `conventions.md`.
  새 암묵적 규칙이 생겼는가? `conventions.md`에 추가하라.

---

## Step 4. Check Freshness — 신선도 확인

Knowledge rots silently. This step prevents it.
지식은 조용히 썩는다. 이 단계가 방지한다.

- Scan the `learning/` directory listing. Check documents you referenced during this session and any that look relevant but were not referenced.
  `learning/` 디렉토리 목록을 훑어라. 이 세션에서 참조한 문서와 관련 있어 보이지만 참조하지 않은 문서를 확인하라.
- If any document is outdated, inaccurate, or no longer relevant — flag it. Add a note at the top: `<!-- STALE: [reason] — flagged [date] -->`.
  문서가 오래되었거나, 부정확하거나, 더 이상 관련 없으면 — 알려라. 상단에 노트를 추가하라: `<!-- STALE: [이유] — flagged [날짜] -->`.
- Do not delete. Do not auto-fix. Flag and let humans decide.
  삭제하지 마라. 자동 수정하지 마라. 알리고 인간이 판단하게 하라.

---

## Step 5. Check Onboarding Materials — 온보딩 자료 확인

If the project changed, the tour must change too.
프로젝트가 바뀌었으면, 투어도 바뀌어야 한다.

- Did this session change architecture, introduce new patterns, or alter boundaries?
  이 세션이 아키텍처를 바꾸었거나, 새 패턴을 도입했거나, 경계를 변경했는가?
- If yes: check whether `learning/onboarding/` materials still reflect reality. Small corrections — fix directly. Large rewrites — add to `context/backlog.md`.
  그렇다면: `learning/onboarding/` 자료가 여전히 현실을 반영하는지 확인하라. 작은 수정 — 직접 고쳐라. 대규모 재작성 — `context/backlog.md`에 추가하라.
- If no changes: skip.
  변경 없으면: 건너뛰어라.

---

## Step 6. Write Session Summary — 세션 요약 작성

Write to `memory/`:
`memory/`에 작성:

- **Completed**: What was done.
  완료한 것.
- **Incomplete**: What remains and why.
  미완료한 것과 이유.
- **Next**: What the next session should know or do first.
  다음 세션이 알아야 할 것 또는 먼저 해야 할 것.

This is the minimum. Every session produces this, even if all other steps were skipped.
이것이 최소다. 다른 모든 단계를 건너뛰더라도, 모든 세션이 이것을 남긴다.
