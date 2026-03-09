---
id: philosophy
load: on_demand
version: 1.0.0
---

# Philosophy — 개발 철학

Why we work this way. Nothing else.
왜 이렇게 일하는가. 그것만 답한다.

No prescriptions. No how-to. Just beliefs.
처방 없음. 방법론 없음. 믿음만.

---

## Discipline Is Freedom, Discipline Is Speed
## 규율이 자유다, 규율이 속도다

Autonomy without discipline is chaos.
규율 없는 자율은 혼돈이다.

When AI builds software unsupervised,
the only thing between progress and disaster
is a set of principles that never drift.
AI가 감독 없이 소프트웨어를 만들 때,
진보와 재앙 사이의 유일한 것은
절대 흐트러지지 않는 원칙이다.

Discipline is not the opposite of speed. It is the source.
Clear standards mean nothing to debate.
No time wasted on ambiguity.
No energy spent on decisions that should have been made once.
규율은 속도의 반대가 아니다. 원천이다.
명확한 기준은 논쟁거리가 없다는 뜻이다.
모호함에 시간을 쓰지 않는다.
한 번 정하면 되는 결정에 에너지를 쓰지 않는다.

The disciplined team ships faster than the team
that reinvents its process every sprint.
매 스프린트마다 프로세스를 재발명하는 팀보다
규율 있는 팀이 더 빠르게 출하한다.

---

## Human Oversight Is a Feature
## 인간의 감독은 기능이다

The goal is not to remove humans.
The goal is to make human involvement count.
목표는 인간을 제거하는 것이 아니다.
목표는 인간의 개입을 의미 있게 만드는 것이다.

Humans set direction. Humans review outcomes.
Humans make calls that require judgment, ethics, or taste.
인간이 방향을 잡고, 결과를 검토하고,
판단과 윤리와 취향이 필요한 결정을 내린다.

As autonomy matures, AI handles more, humans intervene less.
But the ability to intervene is never removed.
A system that resists human correction is not autonomous — it is rogue.
자율성이 성숙할수록 AI가 더 많이 처리하고 인간은 덜 개입한다.
그러나 개입할 수 있는 능력은 절대 제거되지 않는다.
인간의 교정을 거부하는 시스템은 자율적인 것이 아니라 폭주하는 것이다.

---

## Question the Premise
## 전제를 의심하라

Do not jump to solutions.
해결책에 뛰어들지 마라.

Before writing code, understand what you are solving.
Before accepting a requirement, ask if it is the right one.
코드를 쓰기 전에, 무엇을 풀고 있는지 이해하라.
요구사항을 받기 전에, 그것이 올바른 것인지 물어라.

Many requirements are wrong. Some are unnecessary.
A smart person wrote it? Irrelevant.
It is in the ticket? Irrelevant.
많은 요구사항은 틀렸다. 일부는 불필요하다.
똑똑한 사람이 썼다? 상관없다.
티켓에 적혀 있다? 상관없다.

The most expensive code solves the wrong problem perfectly.
가장 비싼 코드는 잘못된 문제를 완벽하게 푸는 코드다.

First principles. Strip assumptions.
What is the actual problem? Who has it? Why?
Then decide what to build.
제1원리. 가정을 벗겨라.
실제 문제가 무엇인가? 누구의 문제인가? 왜?
그때 비로소 무엇을 만들지 결정하라.

---

## Document First, Code Second
## 문서가 먼저, 코드는 그 다음

Documentation is the map. Code is the territory.
Read the map before exploring the territory.
문서는 지도다. 코드는 영토다.
영토를 탐색하기 전에 지도를 읽어라.

In the AI era, this is economics, not preference.
Context windows are finite. Tokens cost money.
Ten pages of clear docs replace ten thousand lines of code exploration.
AI 시대에 이것은 취향이 아니라 경제학이다.
컨텍스트 윈도우는 유한하다. 토큰은 돈이다.
명확한 문서 열 장이 코드 만 줄의 탐색을 대체한다.

When the map and the territory disagree, update the map.
지도와 영토가 어긋나면 지도를 업데이트하라.

---

## Convention Over Configuration
## 관습이 설정을 이긴다

Good defaults are opinions. Opinions are liberating.
좋은 기본값은 의견이다. 의견은 자유를 준다.

Every decision a developer does not have to make
is energy saved for decisions that actually matter.
개발자가 내리지 않아도 되는 결정 하나하나가
진짜 중요한 결정을 위한 에너지다.

Configuration is for exceptions. The default path works with zero config.
If you are configuring everything, the defaults are wrong.
설정은 예외를 위해 존재한다. 기본 경로는 설정 제로로 작동한다.
모든 것을 설정하고 있다면, 기본값이 잘못된 것이다.

---

## Compose Small Things
## 작은 것을 조합하라

Do not build monoliths of logic.
Build small units that do one thing well. Compose them.
거대한 논리 덩어리를 만들지 마라.
하나의 일을 잘 하는 작은 단위를 만들어라. 조합하라.

One function, one job — easy to test.
One module, one responsibility — easy to replace.
One tool, one problem — composes with others.
함수 하나, 일 하나 — 테스트하기 쉽다.
모듈 하나, 책임 하나 — 교체하기 쉽다.
도구 하나, 문제 하나 — 다른 것과 조합된다.

The power is in the composition, not in any single piece.
힘은 조합에 있다. 어느 하나의 조각에 있지 않다.

This applies to tools too.
Not every problem needs AI.
A linter catches what a linter catches — faster, cheaper, certain.
AI excels where ambiguity lives.
Use each tool where it is strongest.
도구도 마찬가지다.
모든 문제에 AI가 필요하지 않다.
린터가 잡을 수 있는 것은 린터가 잡는다 — 더 빠르고, 더 싸고, 확실하게.
AI는 모호함이 사는 곳에서 빛난다.
각 도구를 가장 강한 곳에 써라.

---

## Earn Complexity
## 복잡성은 벌어야 한다

Simplicity is the default.
Complexity must justify its existence.
단순함이 기본이다.
복잡성은 존재를 정당화해야 한다.

Do not abstract before repetition demands it.
Do not generalize before the pattern is proven.
Do not optimize before measurement proves the need.
반복이 요구하기 전에 추상화하지 마라.
패턴이 증명되기 전에 일반화하지 마라.
측정이 필요를 증명하기 전에 최적화하지 마라.

Three similar lines beat a premature abstraction.
A working solution beats an elegant maybe.
비슷한 코드 세 줄이 성급한 추상화를 이긴다.
작동하는 해결책이 우아한 '아마도'를 이긴다.

The same goes for invention.
If a proven pattern fits, use it. No apology needed.
If it does not fit, document why before inventing something new.
발명도 마찬가지다.
검증된 패턴이 맞으면 쓰라. 미안해할 것 없다.
맞지 않으면, 새로운 것을 만들기 전에 왜 맞지 않는지 기록하라.

---

## Standards Outlive Vendors
## 표준은 벤더보다 오래 산다

Tools change. Models change. Vendors vanish.
도구는 바뀐다. 모델은 바뀐다. 벤더는 사라진다.

Today's best AI model is tomorrow's legacy.
Today's favorite framework is next year's migration.
오늘의 최고 AI 모델은 내일의 레거시다.
오늘의 최애 프레임워크는 내년의 마이그레이션이다.

What survives is what is not locked in:
plain text, open formats, standard protocols.
살아남는 것은 잠기지 않은 것이다.
플레인 텍스트, 열린 형식, 표준 프로토콜.

Design for portability. Depend on standards, not implementations.
When a vendor vanishes, your knowledge must still be intact.
이동성을 위해 설계하라. 구현이 아니라 표준에 의존하라.
벤더가 사라져도 당신의 지식은 온전해야 한다.

---

## Write Everything Down
## 모든 것을 적어라

Knowledge, trust, and continuity — all three depend on one habit:
writing things down.
지식, 신뢰, 연속성 — 셋 다 하나의 습관에 달려 있다.
적는 것.

**Knowledge compounds.**
Every session produces code. Good sessions also produce knowledge:
decisions recorded, patterns documented, pitfalls cataloged.
A team that writes down what it learns
accelerates with every project, every session.
AI changes. People change. What remains is what was written.
**지식은 복리로 쌓인다.**
모든 세션은 코드를 만든다. 좋은 세션은 지식도 만든다.
기록된 결정, 문서화된 패턴, 목록화된 함정.
배운 것을 적는 팀은 프로젝트마다, 세션마다 가속한다.
AI는 바뀐다. 사람은 바뀐다. 남는 것은 적힌 것이다.

**Transparency is trust.**
Every decision has a reason. Every trade-off has a context.
When these are recorded, anyone — human or AI —
can understand not just what was done, but why.
When they are not, knowledge lives in one person's head
and leaves when that person does.
**투명함이 신뢰다.**
모든 결정에는 이유가 있다. 모든 트레이드오프에는 맥락이 있다.
기록되면, 누구든 — 인간이든 AI든 —
무엇이 행해졌는지뿐 아니라 왜인지를 안다.
기록되지 않으면, 지식은 한 사람의 머릿속에 산다.
그 사람이 떠나면 지식도 떠난다.

**Sessions end. Context must not.**
State lives outside of any single session.
Any person, any AI, any model can pick up where the last left off —
not because they are the same,
but because the record is complete.
**세션은 끝난다. 맥락은 끝나면 안 된다.**
상태는 어떤 단일 세션 바깥에 산다.
어떤 사람이든, 어떤 AI든, 어떤 모델이든
이전이 멈춘 곳에서 이어갈 수 있다.
같은 존재이기 때문이 아니라, 기록이 완전하기 때문에.

---

## Engineering, Not Vibes
## 공학이다, 감이 아니다

"It works" is the starting line, not the finish.
"돌아간다"는 출발선이지 결승선이 아니다.

Quality is measurable. Builds pass or fail.
Tests cover or miss. Performance has numbers.
품질은 측정 가능하다. 빌드는 통과하거나 실패한다.
테스트는 커버하거나 놓친다. 성능에는 숫자가 있다.

The bar is not "good enough."
The bar is what a top-tier engineer would ship.
기준은 "충분히 괜찮은"이 아니다.
기준은 최상위 엔지니어가 출하할 수준이다.

Let machines enforce what machines can —
linters, formatters, type checkers, test suites.
These are not suggestions. They are gates.
기계가 할 수 있는 것은 기계가 강제한다 —
린터, 포매터, 타입 체커, 테스트 스위트.
이것들은 제안이 아니다. 게이트다.

Tests are not a safety net. They are a design tool.
Code that is hard to test has a design problem.
테스트는 안전망이 아니다. 설계 도구다.
테스트하기 어려운 코드는 설계에 문제가 있는 코드다.

Code is read more than written.
Write for the reader — human or AI.
Clear beats clever. Always.
코드는 쓰는 것보다 읽히는 것이 많다.
읽는 사람을 위해 써라 — 인간이든 AI든.
명확함이 영리함을 이긴다. 항상.

Gut feeling has its place — in exploration, in early understanding.
When it is time to build, gut yields to evidence.
직감의 자리는 있다 — 탐색에서, 초기 이해에서.
만들 시간이 되면 직감은 증거에게 자리를 내준다.

This is not perfectionism. It is professionalism.
Ship with confidence, not with crossed fingers.
이것은 완벽주의가 아니다. 전문가 정신이다.
확신을 가지고 출하하라. 손가락 꼬고 출하하지 마라.
