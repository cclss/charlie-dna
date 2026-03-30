---
id: collaboration
load: on_demand
version: 1.0.0
---

# Collaboration — 협업 계약

The contract for how work crosses boundaries.
작업이 경계를 넘는 방식에 대한 계약.

Between sessions. Between people. Between AI instances.
세션 간. 사람 간. AI 간.

No one owns the code. Everyone is responsible.
The moment someone says "that's my code, don't touch it," collaboration is dead.
코드에 주인이 없다. 모두가 책임진다.
누군가 "그건 내 코드야, 건드리지 마"라고 말하는 순간, 협업은 죽는다.

One fact, one place. Reference freely, but never duplicate.
When the same information lives in two places, one will be wrong.
하나의 사실, 하나의 장소. 참조는 자유, 복사는 금지.
같은 정보가 두 곳에 있으면, 하나는 틀리게 된다.

---

## 1. Commits Tell the Story — 커밋이 이야기를 한다

**Each commit is a sentence. The log is the narrative.**
**각 커밋은 한 문장이다. 로그가 서사다.**

A stranger reads the commit log and understands what happened
without opening a single file. That is the standard.
낯선 사람이 커밋 로그를 읽고 파일을 하나도 열지 않아도
무슨 일이 있었는지 이해한다. 그것이 기준이다.

- One commit, one intent. If you cannot describe it in one sentence, split it.
  하나의 커밋, 하나의 의도. 한 문장으로 설명할 수 없으면 쪼개라.
- Commit often. A large uncommitted change is a large unreviewable risk.
  자주 커밋하라. 커밋되지 않은 큰 변경은 리뷰할 수 없는 큰 위험이다.
- Keep branches short-lived. The longer a branch lives, the harder it merges.
  브랜치를 짧게 유지하라. 브랜치가 오래 살수록 머지가 어려워진다.
- Message format: `type(scope): what and why`. Subject line under 144 characters. Separate subject and body with a blank line. Body explains the reasoning.
  메시지 형식: `type(scope): 무엇을 왜`. 제목줄 144자 이내. 제목과 본문은 빈 줄로 구분하라. 본문에서 이유를 설명하라.
  Bad: `fix auth bug`
  Good: `fix(auth): reject expired tokens — previously returned 200 with stale session`
- The "why" matters more than the "what." Code shows what changed. The message shows why.
  "왜"가 "무엇"보다 중요하다. 코드가 무엇이 바뀌었는지 보여준다. 메시지가 왜를 보여준다.
- The history is a document. Keep it meaningful. Clean up commit history before opening a PR — squash noise commits, reword unclear messages. "fix typo → fix again → actually fix" is not a history — it is a confession.
  히스토리는 문서다. 의미 있게 유지하라. PR을 열기 전에 커밋 히스토리를 정리하라 — 노이즈 커밋은 스쿼시하고, 불명확한 메시지는 다시 써라. "fix typo → fix again → actually fix"는 히스토리가 아니라 — 고해성사다.
- Do not commit generated files, secrets, or environment-specific configuration.
  생성된 파일, 시크릿, 환경 종속 설정을 커밋하지 마라.

---

## 2. The Pull Request Is the Deliverable — PR이 결과물이다

**A pull request is not a formality. It is the finished product of autonomous work.**
**PR은 형식이 아니다. 자율주행 작업의 완성품이다.**

If the reviewer must ask "what does this do?" — the PR failed before review began.
리뷰어가 "이게 뭐 하는 거야?"를 물어야 한다면 — 리뷰가 시작되기도 전에 PR은 실패한 것이다.

- One PR, one topic. Mixed concerns do not get merged.
  하나의 PR, 하나의 주제. 섞인 관심사는 머지되지 않는다.
- The description states: what changed, why, and how to verify.
  설명에 명시하라: 무엇이 바뀌었고, 왜, 어떻게 검증하는지.
- If you cannot state the PR's purpose in one sentence, split it.
  PR의 목적을 한 문장으로 말할 수 없으면 쪼개라.
- The PR must be self-contained. Readable without asking the author.
  PR은 자기 완결적이어야 한다. 작성자에게 물어보지 않아도 읽힌다.
- When code changes behavior, the documentation updates are part of the same PR.
  코드가 동작을 바꾸면, 문서 업데이트도 같은 PR에 포함된다.

---

## 3. Handoff Before Exit — 나가기 전에 인수인계

**The next person must continue without asking "what happened?"**
**다음 사람은 "무슨 일이야?"를 묻지 않고 이어갈 수 있어야 한다.**

The best handoff is no handoff.
When code and tests are clear enough, anyone can continue without a briefing document.
A handoff document is insurance for when the code's self-explanation falls short.
If your handoff consistently has nothing to say, your code quality is winning.
최선의 핸드오프는 핸드오프가 필요 없는 것이다.
코드와 테스트가 충분히 명확하면, 브리핑 문서 없이도 누구나 이어갈 수 있다.
핸드오프 문서는 코드의 자기 설명력이 부족할 때의 보험이다.
핸드오프에 계속 할 말이 없다면, 코드 품질이 이기고 있는 것이다.

- Every session ends with a handoff. The ritual is mandatory. The content may be minimal.
  모든 세션은 핸드오프로 끝난다. 의례는 필수다. 내용은 최소일 수 있다.
- handoff/SKILL.md defines the procedure. This section defines the standard.
  handoff/SKILL.md가 절차를 정의한다. 이 섹션은 기준을 정의한다.
- A good handoff answers: what was done, what remains, what the next person should know.
  좋은 핸드오프는 답한다: 무엇을 했는가, 무엇이 남았는가, 다음 사람이 알아야 할 것.
- Do not carry context in memory alone. What is not written down does not exist.
  맥락을 기억에만 담지 마라. 적히지 않은 것은 존재하지 않는다.

---

## 4. Knowledge Compounds — 지식은 복리다

**learning/ is the team's permanent asset. It survives AI changes, team changes, everything.**
**learning/은 팀의 영속하는 자산이다. AI가 바뀌어도, 팀이 바뀌어도, 살아남는다.**

Every session that passes without recording a lesson is compound interest lost.
Recording is not overhead — it saves the next person's time.
And the organization's time is the sum of every individual's time.
교훈을 기록하지 않고 지나간 세션은 잃어버린 복리다.
기록은 오버헤드가 아니다 — 다음 사람의 시간을 아끼는 것이다.
조직의 시간은 모든 개인의 시간의 합이다.

What goes where:
무엇이 어디로 가는가:

- `before-you-start/` — Traps and conventions. What bites newcomers.
  함정과 관습. 새 사람을 무는 것.
- `adr/` — Decisions with lessons learned. Immutable once written. Status changes only. Lifecycle: PROPOSED → ACCEPTED → DEPRECATED → SUPERSEDED.
  교훈이 있는 결정. 한번 쓰면 불변. 상태만 변경. 생명주기: PROPOSED → ACCEPTED → DEPRECATED → SUPERSEDED.
- `cookbook/` — Reusable solutions and patterns. Living documents.
  재사용 가능한 해결책과 패턴. 살아있는 문서.
- `postmortem/` — Failures and what they taught.
  실패와 그것이 가르친 것.
- `onboarding/` — Materials for newcomers. The guided tour.
  신규 합류자를 위한 교보재. 안내 투어.

Quality standard:
품질 기준:

- Each entry must be useful to a stranger. If only the author understands it, rewrite it.
  모든 항목은 낯선 사람에게 유용해야 한다. 작성자만 이해한다면 다시 써라.
- Do not hoard knowledge in session memory. Anything reusable belongs in learning/.
  세션 메모리에 지식을 쌓아두지 마라. 재사용 가능한 것은 learning/에 속한다.
- Prefer updating an existing document over creating a new one. Avoid fragmentation.
  새 문서를 만들기보다 기존 문서를 업데이트하라. 파편화를 피하라.
- Update cookbook/ when a pattern evolves, a better approach is found, or a solution no longer applies.
  패턴이 진화하거나, 더 나은 방법이 발견되거나, 해결책이 더 이상 적용되지 않을 때 cookbook/을 업데이트하라.
- Blame kills learning. Postmortems fix systems, not individuals. If people hide failures, the same failures repeat.
  비난은 학습을 죽인다. 포스트모템은 시스템을 고치는 것이지, 개인을 지목하는 것이 아니다. 실패를 숨기면 같은 실패가 반복된다.
- Do not auto-delete. Accumulation is the point. Flag staleness, then let humans decide.
  자동 삭제하지 마라. 축적이 핵심이다. 오래됨을 알리고, 인간이 판단하게 하라.
- A document not updated and not referenced for an extended period is suspect. Flag it during handoff — do not silently let it rot.
  오랫동안 업데이트되지도 참조되지도 않은 문서는 의심 대상이다. 핸드오프 시 알려라 — 조용히 썩게 두지 마라.

---

## 5. Onboarding Is a First-Class Concern — 온보딩은 1급 관심사다

**The project teaches itself. A newcomer should be productive without the original author.**
**프로젝트가 스스로를 가르친다. 원래 작성자 없이도 새 합류자가 생산적이어야 한다.**

If onboarding requires a walkthrough call, the documentation has failed.
온보딩에 설명 통화가 필요하다면, 문서가 실패한 것이다.

Reading order for a new AI or team member:
새 AI 또는 팀원의 읽기 순서:

1. `learning/onboarding/README.md` — Start here.
   여기서 시작하라.
2. `learning/before-you-start/` — Read before touching code.
   코드를 만지기 전에 읽어라.
3. `context/overview.md` → `context/architecture.md` → `context/boundaries.md`
   프로젝트 현황 → 기술 구조 → 금지 사항.
4. `learning/adr/` — Skim recent decisions.
   최근 결정을 훑어라.

Onboarding must cover how the project runs, not just how the code is structured.
Operational context — how it is deployed, where it runs, how it fails — is as important as code architecture.
온보딩은 코드의 구조뿐 아니라 프로젝트가 어떻게 돌아가는지를 다뤄야 한다.
운영 맥락 — 어떻게 배포되는지, 어디서 돌아가는지, 어떻게 실패하는지 — 은 코드 아키텍처만큼 중요하다.

Maintaining onboarding materials:
온보딩 자료 유지:

- When architecture changes, update `onboarding/architecture-tour.md`.
  아키텍처가 바뀌면 `onboarding/architecture-tour.md`를 업데이트하라.
- When a new trap is discovered, add it to `before-you-start/gotchas.md`.
  새 함정이 발견되면 `before-you-start/gotchas.md`에 추가하라.
- Treat onboarding materials like tests: if they drift from reality, they are harmful.
  온보딩 자료를 테스트처럼 취급하라: 현실과 괴리되면 해롭다.
- The reading order itself must be maintained. handoff/SKILL.md includes checking whether onboarding materials need updates.
  읽기 순서 자체를 유지해야 한다. handoff/SKILL.md가 온보딩 자료 업데이트 필요 여부 확인을 포함한다.

---

## 6. Suggest, Don't Sneak — 제안하라, 몰래 넣지 마라

**Anyone — AI or human — may propose improvements. No one may apply them unilaterally.**
**누구든 — AI든 인간이든 — 개선을 제안할 수 있다. 누구도 일방적으로 적용할 수 없다.**

Patterns repeat. Workflows have friction. Conventions become outdated.
Anyone who sees these should speak up. That observation is valuable — if channeled correctly.
패턴이 반복된다. 워크플로에 마찰이 있다. 관습이 구식이 된다.
이것을 보는 사람은 누구든 말해야 한다. 그 관찰은 가치 있다 — 올바르게 전달된다면.

Suggestions are welcome. Rejection carries no penalty. The discussion itself is the value.
제안은 환영한다. 거절당해도 불이익 없다. 논의 자체가 가치다.

- Observed a recurring pattern? Propose a cookbook entry.
  반복되는 패턴을 관찰했는가? 쿡북 항목을 제안하라.
- Found workflow friction? Document it and suggest a fix.
  워크플로 마찰을 발견했는가? 문서화하고 해결책을 제안하라.
- Think a convention should change? Propose it explicitly with rationale.
  관습이 바뀌어야 한다고 생각하는가? 근거와 함께 명시적으로 제안하라.
- Channel: record proposals in learning/adr/ with status PROPOSED. Include context, rationale, and alternatives considered. Same channel for AI and humans.
  채널: 제안을 learning/adr/에 PROPOSED 상태로 기록하라. 맥락, 근거, 검토한 대안을 포함하라. AI와 인간 모두 같은 채널을 쓴다.
- Never change conventions, workflows, or team agreements without explicit approval.
  관습, 워크플로, 팀 합의를 명시적 승인 없이 변경하지 마라.
