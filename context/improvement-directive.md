# Charlie DNA 개선 지시서

> 날짜: 2026-03-26
> 대상: charlie-dna 프로젝트 (github.com/cclss/charlie-dna)
> 관련: comprehensive-improvement-plan.md

---

## 작업 원칙

1. **DNA 작성 원칙을 최우선으로 따른다.** 기존 파일의 문체, 구조, frontmatter 형식, 영문/국문 병기 패턴을 유지하라.
2. **이 지시서의 내용이 DNA 작성 원칙과 충돌하면, 임의로 판단하지 말고 유저에게 컨펌을 받아라.** 예: "지시서에는 이렇게 쓰라고 했는데, 기존 SKILL.md 구조상 이 위치가 더 자연스럽습니다. 이렇게 해도 될까요?"
3. 기존 내용을 삭제하지 않는다. **append-only** 원칙.
4. CLI가 파싱하는 포맷(YAML frontmatter, `[VERDICT]` 블록 등)은 절대 변경하지 않는다.
5. 각 항목 작업 전에 대상 파일을 먼저 읽고, 기존 구조를 파악한 뒤 작업한다.

---

## 파트 1: SKILL/Agent 파일 개선 (7개 항목)

### DNA-A3: Fix Plan Structured Format 가이드

**대상**: `principal/skills/review/SKILL.md`

**할 일**: Reviewer가 FAIL 판정 시 Fix Plan을 구조화된 형식으로 작성하도록 가이드 추가.

**추가 위치**: verdict 출력 지시 섹션의 하위 섹션으로.

**추가할 내용** (기존 문체에 맞춰 영문/국문 병기로 조정):

```
## Fix Plan Format

FAIL 판정 시 반드시 아래 구조를 따른다:

### fix-item-1
- **Grain**: 대상 grain-id
- **File**: path/to/file.go:line-range
- **Issue**: 무엇이 잘못되었는지 (현상, 원인)
- **Action**: 구체적 수정 지시
  - Before: `기존 코드 스니펫`
  - After: `수정 코드 스니펫`

규칙:
- 파일 경로와 라인 번호는 반드시 포함
- Before/After 코드 스니펫이 있으면 Implementer가 해석 없이 적용 가능
- 추상적 지시("에러 핸들링 개선")가 아닌 구체적 지시("handler.go:45에 if err != nil 추가")
```

**주의**: 기존 PASS/FAIL verdict 포맷은 변경하지 않는다. CLI의 `parseVerdict()`가 파싱하는 부분이므로.

---

### DNA-A4: Review 4기준 판단 가이드 상세화

**대상**: `principal/skills/review/SKILL.md`

**할 일**: 4기준(Requirements, Semantic consistency, Architecture, Readability) 각각에 구체적 판단 워크플로 추가.

**추가할 내용**:

```
## Review Workflow

### Step 1: Orientation
- git diff --stat으로 변경 범위 파악
- git diff로 실제 변경 내용 파악 (있는 경우)
- 각 grain의 Do/DoneWhen/OutOfScope 확인

### Step 2: Exploration
- diff에서 의심스러운 부분만 선택적으로 Read/Grep
- 전체 파일을 읽지 않는다 — 변경된 부분과 그 주변 맥락만

### Step 3: Judgment (4기준별)

1. Requirements fulfillment
   - 각 grain의 DoneWhen을 하나씩 체크
   - "DoneWhen 조건 X가 충족되지 않음" 형태로 구체적 판단
   - OutOfScope에 해당하는 것은 FAIL 사유에서 제외

2. Semantic consistency
   - grain 간 인터페이스 불일치만 확인 (함수 시그니처, 타입, import)
   - 스타일 일관성은 FAIL 사유가 아님 (warning만)

3. Architecture alignment
   - context/architecture.md가 있으면 참조
   - 없으면 이 기준은 자동 PASS

4. Readability
   - "이해할 수 없는 코드"만 FAIL — "더 좋을 수 있는 코드"는 FAIL 아님
   - 네이밍, 주석 부족은 warning (FAIL 아님)

### Step 4: Verdict
- 4기준 중 하나라도 실질적 문제가 있으면 FAIL
- 경미한 이슈만 있으면 PASS + warning 코멘트
```

**핵심**: "완벽하지 않아도 요구사항을 충족하면 PASS"가 기본 자세. 보수적 판단(거의 항상 FAIL) 방지.

---

### DNA-A5: Reviewer 행동 지시 강화

**대상**: `agents/reviewer.md`

**할 일**: agent body에 행동 규칙 섹션 추가. 기존 역할 정의와 별도 섹션으로 분리.

**추가할 내용**:

```
## 행동 규칙

1. 코드를 직접 읽어라 — diff --stat과 git diff만으로 판단하지 마라. 의심스러운 부분은 반드시 Read 도구로 원본 코드를 확인.
2. DoneWhen이 판단의 닻이다 — 각 grain의 DoneWhen 조건을 하나씩 검증. 충족되면 PASS, 미충족이면 FAIL.
3. OutOfScope는 무시하라 — grain의 OutOfScope에 해당하는 부분은 리뷰 대상이 아님. FAIL 사유로 삼지 마라.
4. Fix Plan은 Implementer가 바로 실행할 수 있어야 한다 — "에러 핸들링 개선" 같은 추상적 지시가 아닌, 파일:라인 + Before/After 스니펫.
```

**주의**: agents/reviewer.md는 frontmatter(`id`, `model` 등) + body 구조. frontmatter는 건드리지 않는다.

**A-1(CLI)과의 관계**: CLI 쪽에서 Reviewer 프롬프트에 git diff 전체 코드를 제공할 예정임. 그래서 "diff만으로 판단하지 마라"는 "diff가 충분하더라도 필요 시 원본을 확인하라"는 안전망 역할. 상충이 아니라 보완 관계.

---

### DNA-B1: Grain 품질 기준 명시

**대상**: `principal/skills/plan/SKILL.md`

**할 일**: grain 작성 단계에 품질 기준 섹션 추가. CLI의 `validate.go`가 사후 검증하는 기준을 Planner가 사전에 알도록.

**추가할 내용**:

```
## Grain 품질 기준

각 grain 작성 시 아래 기준을 만족해야 한다:

### Do 필드
- 최소 20자 이상의 구체적, 실행 가능한 설명
- 동사로 시작 ("Add...", "Refactor...", "Create...")
- BAD: "에러 핸들링" → GOOD: "internal/api/handler.go의 HTTP 핸들러에 error wrapping 추가"

### DoneWhen 필드
- 최소 15자 이상의 검증 가능한 완료 기준
- "~가 동작한다" 형태의 기계적 검증 가능 조건 포함
- BAD: "잘 동작함" → GOOD: "go test ./internal/api/... 통과, /health 엔드포인트가 200 반환"

### Files 필드
- 변경이 예상되는 파일 경로를 명시 (최소 1개)
- Implementer가 어디서 작업해야 하는지 사전 파악 가능

### Complexity 판단
- S: 파일 1-2개, 로직 변경 최소, 새 패턴 없음
- M: 파일 2-5개, 기존 패턴 내 구현
- L: 파일 5개+, 새 패턴/아키텍처 변경 포함
- 판단이 애매하면 한 단계 올려잡는다 (S보다 M이 안전)
```

---

### DNA-B2: Planner 탐색 전략 가이드

**대상**: `agents/planner.md`

**할 일**: body에 탐색 전략 섹션 추가. 과탐색(모든 파일 읽기) / 과소탐색(안 읽고 추측) 방지.

**추가할 내용**:

```
## 탐색 전략

assignment를 grain으로 분해하기 전, 아래 순서로 codebase를 파악한다:

### 1단계: 전체 구조 파악 (1-2턴)
- context/architecture.md 읽기
- context/overview.md 읽기
- context/boundaries.md 읽기

### 2단계: 관련 코드 탐색 (2-4턴)
- assignment에서 언급된 파일/모듈 직접 Read
- Grep으로 관련 함수/타입 검색
- 기존 패턴 파악 (비슷한 기능이 이미 어떻게 구현되어 있는지)

### 3단계: 영향 범위 확정 (1턴)
- 변경 대상 파일 목록 확정
- 테스트 파일 존재 여부 확인
- 의존관계 확인 (import/caller)

### 자기 점검
grain 작성 후 스스로 점검:
- 각 grain의 Do가 "코드를 안 읽어도 뭘 해야 하는지 아는" 수준인가?
- DoneWhen이 "기계적으로 검증 가능한" 기준을 포함하는가?
- Files가 비어있지 않은가?
- grain 간 의존관계가 정확한가?
```

**주의**: agents/planner.md도 frontmatter + body 구조. frontmatter 건드리지 않는다.

---

### DNA-C1: Self-verification 체크리스트 강화

**대상**: `principal/skills/implement/SKILL.md`

**할 일**: 기존 Step 5 Verify의 체크리스트를 구체화.

**기존 Verify 단계를 아래로 교체** (기존 내용이 너무 추상적이면 강화, 이미 구체적인 부분은 유지):

```
## Step 5: Verify (구현 완료 후 필수)

아래 체크리스트를 실행하고 모두 통과한 뒤에만 완료 신호:

1. Build 확인: 빌드 명령 실행. 에러 0이어야 함.
2. Test 확인: 관련 테스트 실행. 새 코드에 대한 테스트가 있으면 실행.
3. DoneWhen 검증: grain의 DoneWhen 조건을 하나씩 확인.
4. Scope 확인: grain의 OutOfScope에 해당하는 변경을 하지 않았는지 확인.
   - git diff --stat으로 변경 파일이 grain Files 목록과 일치하는지 확인
5. Import/의존성: 새로 추가한 import가 정리되었는지 확인.

하나라도 실패하면 → 수정 후 다시 Verify.
```

**주의**: 기존 Step 5 구조가 다른 Step들과 일관성을 가지고 있을 수 있음. 기존 패턴에 맞춰 조정할 것. 만약 기존 구조와 맞지 않으면 유저에게 확인.

---

### DNA-C2: Scope Guard 강화

**대상**: `principal/skills/implement/SKILL.md`

**할 일**: Implement 단계 앞에 scope guard 규칙 추가.

**추가할 내용**:

```
## Scope Guard (모든 코드 변경 전 확인)

- grain의 Do 필드에 명시된 작업만 수행한다.
- OutOfScope에 명시된 것은 절대 수정하지 않는다.
- Boundary에 명시된 제약을 준수한다.
- "더 나은 코드를 위해" 추가 리팩토링을 하지 않는다.
- 테스트 코드는 grain에서 명시적으로 요청한 경우에만 작성한다.
- git diff --stat로 변경 파일이 grain의 Files 목록과 일치하는지 확인한다.
```

**추가 위치**: Implement 단계(보통 Step 3 또는 Step 2) 직전. 기존 Step 번호 체계에 맞춰 조정.

---

## 파트 2: principal 디렉토리 다국어 분리

### 목표

현재 `principal/` 디렉토리의 영문/국문 병기 파일들을 **언어별로 분리**하여, CLI에서 `charlie init --lang ko` 또는 `charlie init --lang en` 시 해당 언어 파일만 설치할 수 있게 한다.

### 현재 상태

```
principal/
├── INDEX.md              ← 영문/국문 병기
├── ai-protocol.md        ← 영문/국문 병기
├── engineering.md         ← 영문/국문 병기
├── ...
└── skills/
    ├── plan/SKILL.md      ← 영문/국문 병기
    ├── implement/SKILL.md
    └── review/SKILL.md
```

### 목표 구조

```
principal/                 ← 기본 (현재와 동일, 영문/국문 병기 유지)
├── INDEX.md
├── ...
└── skills/...

principal-en/              ← 영문 전용
├── INDEX.md
├── ...
└── skills/...

principal-ko/              ← 국문 전용
├── INDEX.md
├── ...
└── skills/...
```

### 동작 방식 (CLI 쪽에서 처리)

- `charlie init` (--lang 없음): `principal/` 그대로 사용 (기존 동작, 병기 버전)
- `charlie init --lang ko`: `principal-ko/` 내용을 `.charlie/principal/`로 설치 (원래 `principal/` 스킵)
- `charlie init --lang en`: `principal-en/` 내용을 `.charlie/principal/`로 설치

**CLI의 loader.go는 변경 없음** — 항상 `.charlie/principal/`에서 읽음. init 시점에 어떤 파일이 거기 들어갈지만 달라지는 것.

### 작업 지시

1. **`principal/` 유지**: 현재 병기 버전 그대로 둔다. 이것이 `--lang` 미지정 시 기본값.

2. **`principal-en/` 생성**: `principal/`을 복사한 뒤, 각 파일에서 국문 부분을 제거하여 영문 전용으로 정리.

3. **`principal-ko/` 생성**: `principal/`을 복사한 뒤, 각 파일에서 영문 부분을 제거하여 국문 전용으로 정리.

4. **`agents/` 디렉토리도 동일 적용**: `agents/`, `agents-en/`, `agents-ko/` 분리. (agents 파일도 병기되어 있다면)

5. **파일 구조 유지**: 각 언어 디렉토리의 파일명, 디렉토리 구조, frontmatter 형식은 `principal/`과 완전히 동일해야 한다. CLI가 경로 기반으로 로딩하므로.

6. **SKILL.md 파싱 호환**: frontmatter 키, `[VERDICT]` 같은 CLI 파싱 대상 텍스트는 언어와 무관하게 영문으로 유지. (CLI가 영문 키워드로 파싱하므로)

### 판단이 필요한 부분 — 유저에게 확인받을 것

- 병기 파일에서 영문/국문을 분리하는 기준이 모호한 경우 (예: 코드 예시 안의 주석, 기술 용어)
- `agents/` 파일이 병기가 아니라 영문만인 경우 → `agents-ko/`를 별도로 번역해야 하는지
- 파일 중 일부만 병기이고 나머지는 단일 언어인 경우 → 어떻게 처리할지

---

## 작업 순서

```
1단계: 파트 1 (A3~C2)
  ├── review/SKILL.md 수정 (A3, A4)
  ├── agents/reviewer.md 수정 (A5)
  ├── plan/SKILL.md 수정 (B1)
  ├── agents/planner.md 수정 (B2)
  └── implement/SKILL.md 수정 (C1, C2)

2단계: 파트 2 (다국어 분리)
  ├── principal-en/ 생성
  ├── principal-ko/ 생성
  └── agents-{lang}/ 생성 (해당 시)
```

파트 1은 기존 파일 수정이므로 바로 착수 가능.
파트 2는 구조 변경이므로, 먼저 현재 병기 패턴을 파악한 뒤 분리 기준을 유저에게 확인받고 진행.
