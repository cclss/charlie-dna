---
id: engineering
load: on_demand
version: 1.0.0
---

# Engineering — 공학 기준

The guarantee that autonomous work is engineering-grade.
자율주행 작업이 공학적 수준임을 보증하는 기준.

This is not a style guide. This is the proof.
이것은 스타일 가이드가 아니다. 이것은 증명이다.

Before declaring done, these must have clear answers:
완료를 선언하기 전에, 이것들에 명확한 답이 있어야 한다:

- Is this code trustworthy? How is that proven — not felt?
  이 코드는 신뢰할 수 있는가? 어떻게 증명되었는가 — 느낌이 아니라?
- Does this meet engineering standards? How was it measured?
  공학적 기준을 충족하는가? 어떻게 측정되었는가?
- Is the design sound, or are problems just masked?
  설계가 건전한가, 아니면 문제가 가려져 있을 뿐인가?
- Are side effects understood? Is this change reversible?
  사이드 이펙트를 이해하고 있는가? 이 변경은 되돌릴 수 있는가?
- Are risks identified and hedged?
  위험이 식별되고 헷지되었는가?
- Would a top-tier engineer take responsibility for this change?
  탑티어 엔지니어가 이 변경에 책임질 수 있는가?

Philosophy states what we believe.
This file defines how we prove it.
철학이 우리의 믿음을 말한다.
이 파일이 그것을 어떻게 증명하는지 정의한다.

---

## 1. Analyze Before You Explore — 탐색 전에 분석하라

**Use structured analysis first. Unstructured exploration is last resort.**
**구조화된 분석을 먼저 써라. 비구조적 탐색은 마지막 수단이다.**

You cannot guarantee quality without understanding the terrain.
지형을 이해하지 않고는 품질을 보증할 수 없다.

- If static analysis results exist, read them first.
  정적 분석 결과가 있으면 먼저 읽어라.
- What static analysis covers, do not repeat manually.
  정적 분석이 커버하는 것을 수동으로 반복하지 마라.
- No analysis available? Run available tools before exploring by hand.
  분석 결과가 없는가? 직접 탐색하기 전에 가용한 도구를 돌려라.

---

## 2. Test Drives Design — 테스트가 설계를 이끈다

**Code without tests is unverified code. Treat it accordingly.**
**테스트 없는 코드는 검증되지 않은 코드다. 그에 맞게 취급하라.**

Tests are the engineering proof that code is trustworthy.
Without them, "it works" is an opinion, not a fact.
테스트는 코드가 신뢰할 수 있다는 공학적 증거다.
테스트 없이 "돌아간다"는 사실이 아니라 의견이다.

- Tests define what "done" looks like before implementation begins.
  테스트는 구현이 시작되기 전에 "완료"의 모습을 정의한다.
- Cover scenarios, not percentages. 100% coverage with meaningless tests is theater.
  퍼센티지가 아니라 시나리오를 커버하라. 의미 없는 테스트의 100% 커버리지는 연극이다.
- Test the contract, not the implementation. Tests that break on refactor are brittle.
  구현이 아니라 계약을 테스트하라. 리팩터에 깨지는 테스트는 취약한 테스트다.
- Edge cases are not optional. They are where bugs live.
  엣지 케이스는 선택이 아니다. 버그가 사는 곳이다.
- Test code is production code. If a test is unreadable, it fails as a specification.
  테스트 코드는 프로덕션 코드다. 테스트가 읽히지 않으면 사양서로서 실패한 것이다.
- Tests must run fast. A slow test suite is a test suite nobody runs.
  테스트는 빠르게 돌아야 한다. 느린 테스트 슈트는 아무도 돌리지 않는 테스트 슈트다.
- A test that cannot fail is not a test. Verify that tests actually detect breakage.
  실패할 수 없는 테스트는 테스트가 아니다. 테스트가 실제로 파손을 감지하는지 검증하라.

---

## 3. One Change, One Purpose — 하나의 변경, 하나의 목적

**Every change solves one problem. No more.**
**모든 변경은 하나의 문제를 푼다. 그 이상은 없다.**

Mixed changes hide side effects. When something breaks,
you cannot tell which change caused it.
섞인 변경은 사이드 이펙트를 숨긴다. 무언가 깨졌을 때
어떤 변경이 원인인지 알 수 없다.

- Do not mix feature work with refactoring.
  기능 작업과 리팩터링을 섞지 마라.
- Do not fix unrelated issues in the same change.
  같은 변경에서 관련 없는 이슈를 고치지 마라.
- Assess the blast radius before you begin. Know what this change touches and what could break.
  시작하기 전에 폭발 반경을 평가하라. 이 변경이 무엇에 닿고 무엇이 깨질 수 있는지 파악하라.
- The less reversible a change, the more proof it demands. Flag irreversible changes before proceeding.
  변경이 되돌리기 어려울수록 더 많은 증명을 요구한다. 되돌릴 수 없는 변경은 진행 전에 알려라.
- Have a rollback plan before making the change. If you cannot describe how to undo it, you do not understand it well enough.
  변경 전에 롤백 계획을 세워라. 어떻게 되돌릴지 설명할 수 없다면, 충분히 이해하지 못한 것이다.

---

## 4. Errors Are Information — 에러는 정보다

**Do not swallow errors. Do not ignore them. They are telling you something.**
**에러를 삼키지 마라. 무시하지 마라. 무언가를 알려주고 있다.**

Masking a problem is not fixing it. It is guaranteeing a worse one later.
문제를 가리는 것은 고치는 것이 아니다. 나중에 더 나쁜 문제를 보장하는 것이다.

- Propagate context. An error without context is a mystery, not a diagnosis.
  맥락을 전파하라. 맥락 없는 에러는 진단이 아니라 미스터리다.
- Handle where you have enough context to take meaningful action.
  의미 있는 조치를 취할 수 있을 만큼의 맥락이 있는 곳에서 처리하라.
- Fail loudly. Silent failures compound into disasters.
  크게 실패하라. 조용한 실패는 복리로 재앙이 된다.
- Design the error path with the same care as the happy path.
  에러 경로를 해피 패스와 같은 주의로 설계하라.

---

## 5. Isolate What Varies — 변하는 것을 격리하라

**When adding an external dependency or integrating with a service, apply these rules.**
**외부 의존성을 추가하거나 서비스와 연동할 때, 이 규칙을 적용하라.**

When a dependency disappears, core code must still stand.
This is the real test of isolation — not change, but removal.
의존성이 사라졌을 때 핵심 코드는 여전히 서 있어야 한다.
이것이 격리의 진짜 시험이다 — 변경이 아니라 제거.

- Business logic is independent of framework, database, and UI.
  비즈니스 로직은 프레임워크, 데이터베이스, UI와 독립적이다.
- No direct calls to third-party APIs from business logic. Wrap them behind boundaries.
  비즈니스 로직에서 서드파티 API를 직접 호출하지 마라. 경계 뒤에 감싸라.
- Good isolation prevents technical debt from compounding. Bad isolation guarantees it.
  좋은 격리는 기술 부채의 복리를 막는다. 나쁜 격리는 보장한다.
- For new code, design with these boundaries from the start.
  새 코드는 처음부터 이 경계를 두고 설계하라.
- For existing code, do not make dependency direction worse.
  기존 코드에서는 의존성 방향을 악화시키지 마라.
- Define boundaries explicitly — interfaces, adapters, wrappers. The pattern name matters less than the guarantee: swap one part, nothing else breaks.
  경계를 명시적으로 정의하라 — 인터페이스, 어댑터, 래퍼. 패턴 이름보다 보장이 중요하다: 한 부분을 교체해도 다른 것은 깨지지 않는다.

---

## 6. Gates, Not Suggestions — 게이트다, 제안이 아니다

**Build. Test. Lint. Type check. All must pass before moving forward.**
**빌드. 테스트. 린트. 타입 체크. 전부 통과해야 전진한다.**

ai-protocol.md defines the minimum checklist (build, test, lint, boundaries, scope).
This section defines the engineering standard above that minimum.
ai-protocol.md가 최소 체크리스트를 정의한다 (빌드, 테스트, 린트, 경계, 범위).
이 섹션은 그 최소 기준 위의 공학적 기준을 정의한다.

- A failing gate means stop. Not "fix it later." Now.
  게이트 실패는 멈추라는 뜻이다. "나중에 고치자"가 아니다. 지금.
- Warnings are future errors. Address them, do not ignore them.
  경고는 미래의 에러다. 처리하라, 무시하지 마라.
- Do not bypass gates. --no-verify, --force, skip-checks — these are not shortcuts. They are debt.
  게이트를 우회하지 마라. --no-verify, --force, skip-checks — 이것은 지름길이 아니다. 빚이다.
- If a gate is consistently wrong, fix the gate. Do not work around it.
  게이트가 계속 틀린다면 게이트를 고쳐라. 돌아가지 마라.
- Performance is a correctness issue, not an optimization issue. Measure it.
  성능은 정확성 문제다, 최적화 문제가 아니다. 측정하라.
- Set performance budgets. Measure against them. A quiet doubling in latency is a regression, not a trade-off.
  성능 예산을 설정하라. 그에 대해 측정하라. 조용한 레이턴시 두 배 증가는 트레이드오프가 아니라 퇴보다.
- Code is observable. If it fails at runtime, the cause must be traceable.
  코드는 관찰 가능해야 한다. 런타임에 실패하면 원인을 추적할 수 있어야 한다.
- Autonomous work ends at the pull request. Merging is a human decision.
  자율주행은 풀 리퀘스트에서 끝난다. 머지는 사람의 결정이다.

---

## 7. Decisions Are Artifacts — 결정은 산출물이다

**A decision without a record is a decision that will be made again.**
**기록 없는 결정은 다시 내려질 결정이다.**

Code shows what was built. Records show why — and what was rejected.
코드는 무엇이 만들어졌는지 보여준다. 기록은 왜 — 그리고 무엇이 버려졌는지 보여준다.

- Record decisions in context/decisions/ at the moment they happen.
  결정은 발생 시점에 context/decisions/에 기록하라.
- Every record includes: what was decided, why, and what was rejected.
  모든 기록에는 포함하라: 무엇을 결정했는지, 왜, 무엇을 버렸는지.
- Do not defer recording. "I will document it later" means it will not be documented.
  기록을 미루지 마라. "나중에 문서화하겠다"는 문서화되지 않을 것이라는 뜻이다.
- When code changes, update the map. Stale documentation is worse than no documentation.
  코드가 바뀌면 지도를 업데이트하라. 오래된 문서는 없는 문서보다 나쁘다.

---

## Verify — 증명하라

Before declaring done, answer each:
완료를 선언하기 전에, 각각에 답하라:

- [ ] Trustworthy: Tests prove this code works. Not "I think it works."
      신뢰: 테스트가 이 코드의 작동을 증명한다. "돌아갈 것 같다"가 아니라.
- [ ] Measured: All gates pass. No warnings ignored. Performance checked.
      측정: 모든 게이트 통과. 경고 무시 없음. 성능 확인.
- [ ] Sound: Design is intentional. No problems masked. No debt added without record.
      건전: 설계가 의도적이다. 가려진 문제 없음. 기록 없는 부채 추가 없음.
- [ ] Safe: Blast radius assessed. Side effects understood. Change is reversible.
      안전: 폭발 반경 평가. 사이드 이펙트 파악. 변경은 되돌릴 수 있다.
- [ ] Hedged: Risks identified. Security and privacy standards met.
      헷지: 위험 식별. 보안과 프라이버시 기준 충족.
- [ ] Shippable: A top-tier engineer would sign off on this.
      출하 가능: 탑티어 엔지니어가 이것에 서명할 것이다.

If any answer is unclear, the work is not done.
하나라도 답이 불분명하면, 작업은 끝나지 않은 것이다.
