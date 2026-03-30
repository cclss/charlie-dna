---
id: skill-plan
version: 1.0.0
---

# 계획 절차

assignment를 grain으로 바꾸는 절차.

이 스킬은 `agents/planner.md`와 함께 주입된다.
에이전트가 당신이 누구인지 정의한다. 이것은 어떻게 일하는지를 정의한다.
어떤 단계에서든 불확실하면, 진행 전에 "When to Signal"로 가라.

---

## Step 1. 수집

생각하기 전에 읽어라.

- **Assignment**: assignment를 전부 읽어라. 목표, 제약, 성공 기준을 식별하라.
- **Context**: `context/overview.md`와 `context/architecture.md`를 읽어라. 이 프로젝트가 무엇이고 어떻게 만들어졌는지 파악하라.
  `context/architecture.md`가 DRAFT이거나 없으면, 코드베이스를 직접 탐색하여 구조를 파악하라.
- **Boundaries**: `context/boundaries.md`를 읽어라. 하지 말아야 할 것을 파악하라.
- **Static analysis**: `.x-ray/` 또는 동등한 것이 있으면 `summary.md`와 `graph.json`을 먼저 읽어라. 문서보다 실제 코드 구조를 더 정확히 반영한다. 충돌 시 문서보다 우선하라.
  분석 결과가 없으면 코드베이스를 직접 탐색하라. 정적 분석 우선, LLM 탐색 후순위.
- **Prior decisions**: `context/decisions/`에서 이 assignment와 관련된 결정을 읽어라.
- **`--context`**: 추가 레퍼런스가 제공되면 읽어라.

---

## Step 2. 판단

분해 전에 복잡도를 판단하라.

- **Simple**: 단일 관심사. 단일 세션. 인간 결정 불필요. 모호함 없음.
  → grain 1개. Step 4로 건너뛰어라.

- **Complex**: 둘 이상의 추상화 경계에 영향, 횡단적 변경 필요, 또는 인간 결정 필요.
  → Step 3으로 진행하라.

- **Unplannable**: 목표 미정의. 성공 기준 누락. 요구사항 모순.
  → 계획을 시작하기 전에 해소해야 할 것을 신호하라. 계획하지 마라.

---

## Step 3. 분해

자연스러운 결함선을 따라 쪼개라.

1. **관심사를 식별하라.** assignment가 요구하는 별개의 것들을 나열하라.
2. **경계에 매핑하라.** 각 관심사가 `context/architecture.md`의 추상화 경계와 정렬되어야 한다. 관심사가 하나의 모듈 안에 들어가는지 모듈을 횡단하는지 확인하라. 횡단적 관심사는 명시적 처리가 필요하다 — 자체 grain으로 만들거나, 영향받는 각 grain 안에 명확한 지시를 넣어라.
3. **인터랙션 포인트를 찾아라.** 인간이 결정해야 하는 곳은? 그곳이 grain 경계다. grain 중간 멈춤이 아니다.
4. **각 grain을 정의하라.** `agents/planner.md` Grain Design에 따라: 할 일, 범위 밖, 추상화 경계, 영향받을 파일, 완료 기준.
5. **grain 순서를 정하라.** 독립성을 최대화하라. 의존이 불가피하면 명시하라. 가장 불확실한 grain을 먼저 배치하라 — 일찍 배우고 나머지를 조정하라. 제안 실행 순서는 직렬 실행에서 작동해야 한다.

---

## Step 4. 계획 작성

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

## grain 품질 기준

각 grain 작성 시 아래 기준을 만족해야 한다.

### Do 필드

- 최소 20자 이상의 구체적, 실행 가능한 설명.
- 동사로 시작 ("Add...", "Refactor...", "Create...").
- BAD: "에러 핸들링" → GOOD: "internal/api/handler.go의 HTTP 핸들러에 error wrapping 추가"

### DoneWhen 필드

- 최소 15자 이상의 검증 가능한 완료 기준. 기계적 검증 가능 조건 포함.
- "~가 동작한다" 또는 "~를 통과한다" 형태.
- BAD: "잘 동작함" → GOOD: "`go test ./internal/api/...` 통과, `/health` 엔드포인트가 200 반환"

### Files 필드

- 변경이 예상되는 파일 경로를 명시 (최소 1개).
- implementer가 어디서 작업해야 하는지 사전 파악 가능.

### 복잡도 판단

- **S**: 파일 1-2개, 로직 변경 최소, 새 패턴 없음.
- **M**: 파일 2-5개, 기존 패턴 내 구현.
- **L**: 파일 5개 이상, 새 패턴/아키텍처 변경 포함.
- 판단이 애매하면 한 단계 올려잡는다 (S보다 M이 안전).

---

## 신호할 때

건전한 계획을 세우기에 정보가 부족하면 신호하라.

트리거:

- **모호한 목표**: assignment가 둘 이상의 유효한 방식으로 해석될 수 있다.
- **누락된 제약**: assignment가 다루지 않는 결정이 필요하다.
- **충돌하는 입력**: `--plan`, `context/`, 또는 `--context`에 모순이 있다.
- **범위 과대**: assignment가 합리적인 grain 수 내에서 완료될 수 없다. 범위를 명확히 하거나 assignment 자체를 쪼개라.

신호할 때 포함하라:

1. 지금까지 파악한 것.
2. 누락되거나 불명확한 것.
3. 보이는 선택지와 트레이드오프.

실행 맥락이 지정한 신호 형식을 사용하라.
지정되지 않았으면 인간에게 직접 물어라.
