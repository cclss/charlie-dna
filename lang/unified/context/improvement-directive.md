# Charlie DNA Improvement Directive — Charlie DNA 개선 지시서

> Date / 날짜: 2026-03-26
> Target / 대상: charlie-dna project (github.com/cclss/charlie-dna)
> Related / 관련: comprehensive-improvement-plan.md

---

## Working Principles — 작업 원칙

1. **Follow DNA authoring principles first.** Maintain the style, structure, frontmatter format, and bilingual patterns of existing files.
   **DNA 작성 원칙을 최우선으로 따른다.** 기존 파일의 문체, 구조, frontmatter 형식, 영문/국문 병기 패턴을 유지하라.
2. **If this directive conflicts with DNA authoring principles, do not decide on your own — get user confirmation.**
   **이 지시서의 내용이 DNA 작성 원칙과 충돌하면, 임의로 판단하지 말고 유저에게 컨펌을 받아라.**
   E.g.: "The directive says to write it this way, but given the existing SKILL.md structure, this placement feels more natural. Shall I proceed?"
   예: "지시서에는 이렇게 쓰라고 했는데, 기존 SKILL.md 구조상 이 위치가 더 자연스럽습니다. 이렇게 해도 될까요?"
3. Do not delete existing content. **Append-only** principle.
   기존 내용을 삭제하지 않는다. **append-only** 원칙.
4. Never change formats parsed by CLI (YAML frontmatter, `[VERDICT]` blocks, etc.).
   CLI가 파싱하는 포맷(YAML frontmatter, `[VERDICT]` 블록 등)은 절대 변경하지 않는다.
5. Read the target file first before each item, understand the existing structure, then proceed.
   각 항목 작업 전에 대상 파일을 먼저 읽고, 기존 구조를 파악한 뒤 작업한다.

---

## Part 1: SKILL/Agent File Improvements (7 items) — 파트 1: SKILL/Agent 파일 개선 (7개 항목)

### DNA-A3: Fix Plan Structured Format Guide — Fix Plan 구조화 형식 가이드

**Target / 대상**: `principal/skills/review/SKILL.md`

**Task / 할 일**: Add a guide for the Reviewer to write Fix Plans in a structured format when issuing a FAIL verdict.
Reviewer가 FAIL 판정 시 Fix Plan을 구조화된 형식으로 작성하도록 가이드 추가.

**Location / 추가 위치**: As a subsection under the verdict output instructions.
verdict 출력 지시 섹션의 하위 섹션으로.

**Content to add / 추가할 내용**:

```
## Fix Plan Format

When issuing a FAIL verdict, the following structure must be followed:
FAIL 판정 시 반드시 아래 구조를 따른다:

### fix-item-1
- **Grain**: target grain-id / 대상 grain-id
- **File**: path/to/file.go:line-range
- **Issue**: What is wrong (symptom, cause) / 무엇이 잘못되었는지 (현상, 원인)
- **Action**: Specific fix instruction / 구체적 수정 지시
  - Before: `existing code snippet` / `기존 코드 스니펫`
  - After: `corrected code snippet` / `수정 코드 스니펫`

Rules / 규칙:
- File path and line number must always be included / 파일 경로와 라인 번호는 반드시 포함
- When Before/After code snippets are provided, Implementer can apply them without interpretation / Before/After 코드 스니펫이 있으면 Implementer가 해석 없이 적용 가능
- Specific instructions, not abstract ones / 추상적 지시("에러 핸들링 개선")가 아닌 구체적 지시("handler.go:45에 if err != nil 추가")
```

**Caution / 주의**: Do not change the existing PASS/FAIL verdict format. CLI's `parseVerdict()` parses it.
기존 PASS/FAIL verdict 포맷은 변경하지 않는다. CLI의 `parseVerdict()`가 파싱하는 부분이므로.

---

### DNA-A4: Detailed Review 4-Criteria Judgment Guide — Review 4기준 판단 가이드 상세화

**Target / 대상**: `principal/skills/review/SKILL.md`

**Task / 할 일**: Add specific judgment workflows for each of the 4 criteria (Requirements, Semantic consistency, Architecture, Readability).
4기준(Requirements, Semantic consistency, Architecture, Readability) 각각에 구체적 판단 워크플로 추가.

**Content to add / 추가할 내용**:

```
## Review Workflow

### Step 1: Orientation
- Get change scope via git diff --stat / git diff --stat으로 변경 범위 파악
- Get actual changes via git diff / git diff로 실제 변경 내용 파악
- Check each grain's Do/DoneWhen/OutOfScope / 각 grain의 Do/DoneWhen/OutOfScope 확인

### Step 2: Exploration
- Selectively Read/Grep only suspicious parts / diff에서 의심스러운 부분만 선택적으로 Read/Grep
- Do not read entire files — only changed parts and context / 전체 파일을 읽지 않는다 — 변경된 부분과 그 주변 맥락만

### Step 3: Judgment (per criterion / 4기준별)

1. Requirements fulfillment
   - Check each grain's DoneWhen one by one / 각 grain의 DoneWhen을 하나씩 체크
   - Specific judgments: "DoneWhen condition X is not met" / "DoneWhen 조건 X가 충족되지 않음" 형태로 구체적 판단
   - Exclude OutOfScope from FAIL reasons / OutOfScope에 해당하는 것은 FAIL 사유에서 제외

2. Semantic consistency
   - Only check interface mismatches between grains / grain 간 인터페이스 불일치만 확인
   - Style consistency is not a FAIL reason (warning only) / 스타일 일관성은 FAIL 사유가 아님 (warning만)

3. Architecture alignment
   - Reference context/architecture.md if available / context/architecture.md가 있으면 참조
   - If not available, auto-PASS / 없으면 이 기준은 자동 PASS

4. Readability
   - Only FAIL for "incomprehensible code" / "이해할 수 없는 코드"만 FAIL
   - Naming and lack of comments are warnings, not FAIL / 네이밍, 주석 부족은 warning (FAIL 아님)

### Step 4: Verdict
- FAIL if any criterion has a substantive issue / 4기준 중 하나라도 실질적 문제가 있으면 FAIL
- PASS + warning comment if only minor issues / 경미한 이슈만 있으면 PASS + warning 코멘트
```

**Key / 핵심**: Default stance is "PASS if requirements are met, even if not perfect." Prevents conservative judgment.
"완벽하지 않아도 요구사항을 충족하면 PASS"가 기본 자세. 보수적 판단(거의 항상 FAIL) 방지.

---

### DNA-A5: Strengthen Reviewer Behavioral Instructions — Reviewer 행동 지시 강화

**Target / 대상**: `agents/reviewer.md`

**Task / 할 일**: Add a behavioral rules section to the agent body. Separate from existing role definition.
agent body에 행동 규칙 섹션 추가. 기존 역할 정의와 별도 섹션으로 분리.

**Content to add / 추가할 내용**:

```
## Behavioral Rules — 행동 규칙

1. Read the code directly — do not judge by diff alone. Verify suspicious parts with the Read tool.
   코드를 직접 읽어라 — diff만으로 판단하지 마라. 의심스러운 부분은 반드시 Read 도구로 확인.
2. DoneWhen is the anchor of judgment — verify each condition one by one. Met = PASS, not met = FAIL.
   DoneWhen이 판단의 닻이다 — 각 조건을 하나씩 검증. 충족되면 PASS, 미충족이면 FAIL.
3. Ignore OutOfScope — anything there is not a review target. Do not use as FAIL reason.
   OutOfScope는 무시하라 — 해당 부분은 리뷰 대상이 아님. FAIL 사유로 삼지 마라.
4. Fix Plans must be immediately executable — file:line + Before/After snippets, not abstract instructions.
   Fix Plan은 Implementer가 바로 실행할 수 있어야 한다 — 파일:라인 + Before/After 스니펫.
```

**Caution / 주의**: agents/reviewer.md has frontmatter (`id`, `model`, etc.) + body structure. Do not touch frontmatter.
agents/reviewer.md는 frontmatter(`id`, `model` 등) + body 구조. frontmatter는 건드리지 않는다.

**Relationship with A-1 (CLI) / A-1(CLI)과의 관계**: CLI will provide full git diff to the Reviewer prompt. "Don't judge by diff alone" is a safety net — complementary, not conflicting.
CLI 쪽에서 Reviewer 프롬프트에 git diff 전체 코드를 제공할 예정임. "diff만으로 판단하지 마라"는 안전망 역할. 상충이 아니라 보완 관계.

---

### DNA-B1: Specify Grain Quality Criteria — Grain 품질 기준 명시

**Target / 대상**: `principal/skills/plan/SKILL.md`

**Task / 할 일**: Add a quality criteria section to the grain authoring step.
grain 작성 단계에 품질 기준 섹션 추가. CLI의 `validate.go`가 사후 검증하는 기준을 Planner가 사전에 알도록.

**Content to add / 추가할 내용**:

```
## Grain Quality Criteria — Grain 품질 기준

Each grain must satisfy the following:
각 grain 작성 시 아래 기준을 만족해야 한다:

### Do Field / Do 필드
- At least 20 characters, specific, actionable / 최소 20자 이상의 구체적, 실행 가능한 설명
- Start with a verb ("Add...", "Refactor...", "Create...") / 동사로 시작
- BAD: "error handling" → GOOD: "Add error wrapping to HTTP handlers in internal/api/handler.go"

### DoneWhen Field / DoneWhen 필드
- At least 15 characters, verifiable completion criteria / 최소 15자 이상의 검증 가능한 완료 기준
- Include mechanically verifiable conditions / "~가 동작한다" 형태의 기계적 검증 가능 조건 포함
- BAD: "works well" → GOOD: "go test ./internal/api/... passes, /health endpoint returns 200"

### Files Field / Files 필드
- Specify file paths expected to change (at least 1) / 변경이 예상되는 파일 경로를 명시 (최소 1개)
- Lets Implementer know where to work / Implementer가 어디서 작업해야 하는지 사전 파악 가능

### Complexity / Complexity 판단
- S: 1-2 files, minimal logic change, no new patterns / 파일 1-2개, 로직 변경 최소, 새 패턴 없음
- M: 2-5 files, within existing patterns / 파일 2-5개, 기존 패턴 내 구현
- L: 5+ files, new patterns/architecture changes / 파일 5개+, 새 패턴/아키텍처 변경 포함
- When in doubt, round up (M is safer than S) / 판단이 애매하면 한 단계 올려잡는다
```

---

### DNA-B2: Planner Exploration Strategy Guide — Planner 탐색 전략 가이드

**Target / 대상**: `agents/planner.md`

**Task / 할 일**: Add an exploration strategy section. Prevent over-exploration / under-exploration.
body에 탐색 전략 섹션 추가. 과탐색(모든 파일 읽기) / 과소탐색(안 읽고 추측) 방지.

**Content to add / 추가할 내용**:

```
## Exploration Strategy — 탐색 전략

Before breaking an assignment into grains, understand the codebase:
assignment를 grain으로 분해하기 전, 아래 순서로 codebase를 파악한다:

### Phase 1: Overall Structure (1-2 turns) / 1단계: 전체 구조 파악
- Read context/architecture.md
- Read context/overview.md
- Read context/boundaries.md

### Phase 2: Related Code (2-4 turns) / 2단계: 관련 코드 탐색
- Directly Read files/modules mentioned in the assignment / assignment에서 언급된 파일/모듈 직접 Read
- Grep for related functions/types / Grep으로 관련 함수/타입 검색
- Understand existing patterns / 기존 패턴 파악

### Phase 3: Confirm Impact Scope (1 turn) / 3단계: 영향 범위 확정
- Finalize list of files to change / 변경 대상 파일 목록 확정
- Check whether test files exist / 테스트 파일 존재 여부 확인
- Check dependencies (imports/callers) / 의존관계 확인

### Self-Check / 자기 점검
After writing grains: / grain 작성 후 점검:
- Is each Do clear enough to "know what to do without reading the code"? / 각 Do가 "코드를 안 읽어도 뭘 해야 하는지 아는" 수준인가?
- Does DoneWhen include "mechanically verifiable" criteria? / DoneWhen이 "기계적으로 검증 가능한" 기준을 포함하는가?
- Is Files non-empty? / Files가 비어있지 않은가?
- Are inter-grain dependencies accurate? / grain 간 의존관계가 정확한가?
```

**Caution / 주의**: agents/planner.md also has frontmatter + body structure. Do not touch frontmatter.
agents/planner.md도 frontmatter + body 구조. frontmatter 건드리지 않는다.

---

### DNA-C1: Strengthen Self-verification Checklist — Self-verification 체크리스트 강화

**Target / 대상**: `principal/skills/implement/SKILL.md`

**Task / 할 일**: Make the existing Step 5 Verify checklist more concrete.
기존 Step 5 Verify의 체크리스트를 구체화.

**Replace/enhance existing Verify step with / 기존 Verify 단계를 아래로 교체**:

```
## Step 5: Verify (mandatory after implementation / 구현 완료 후 필수)

Execute the checklist below and signal completion only after all pass:
아래 체크리스트를 실행하고 모두 통과한 뒤에만 완료 신호:

1. Build check: Run build command. Must have 0 errors. / Build 확인: 빌드 명령 실행. 에러 0이어야 함.
2. Test check: Run related tests. / Test 확인: 관련 테스트 실행.
3. DoneWhen verification: Check each condition one by one. / DoneWhen 검증: 조건을 하나씩 확인.
4. Scope check: Confirm no OutOfScope changes. / Scope 확인: OutOfScope 변경 없는지 확인.
   - Verify via git diff --stat that changed files match grain's Files list
5. Import/dependencies: Confirm new imports are cleaned up. / Import/의존성: 새 import 정리 확인.

If any fail → fix and re-Verify. / 하나라도 실패하면 → 수정 후 다시 Verify.
```

**Caution / 주의**: Adjust to match existing Step patterns. If it doesn't fit, confirm with user.
기존 Step 구조가 다른 Step들과 일관성을 가지고 있을 수 있음. 기존 패턴에 맞춰 조정할 것.

---

### DNA-C2: Strengthen Scope Guard — Scope Guard 강화

**Target / 대상**: `principal/skills/implement/SKILL.md`

**Task / 할 일**: Add scope guard rules before the Implement step.
Implement 단계 앞에 scope guard 규칙 추가.

**Content to add / 추가할 내용**:

```
## Scope Guard (verify before any code change / 모든 코드 변경 전 확인)

- Only perform work specified in Do. / grain의 Do 필드에 명시된 작업만 수행한다.
- Never modify anything in OutOfScope. / OutOfScope에 명시된 것은 절대 수정하지 않는다.
- Comply with Boundary constraints. / Boundary에 명시된 제약을 준수한다.
- No additional refactoring "for better code." / "더 나은 코드를 위해" 추가 리팩토링을 하지 않는다.
- Only write tests if explicitly requested. / 테스트 코드는 명시적으로 요청한 경우에만 작성한다.
- Verify changed files match grain's Files list. / 변경 파일이 grain의 Files 목록과 일치하는지 확인한다.
```

**Location / 추가 위치**: Just before the Implement step. Adjust to existing step numbering.
Implement 단계 직전. 기존 Step 번호 체계에 맞춰 조정.

---

## Part 2: Multilingual Directory Split — 파트 2: 다국어 디렉토리 분리

### Goal — 목표

Split bilingual files into **language-specific versions** for CLI language selection.
현재 병기 파일들을 **언어별로 분리**하여, CLI에서 언어 선택 시 해당 언어 파일만 설치할 수 있게 한다.

### Current State — 현재 상태

```
principal/
├── INDEX.md              ← bilingual / 영문/국문 병기
├── ai-protocol.md        ← bilingual / 영문/국문 병기
├── engineering.md         ← bilingual / 영문/국문 병기
├── ...
└── skills/
    ├── plan/SKILL.md      ← bilingual / 영문/국문 병기
    ├── implement/SKILL.md
    └── review/SKILL.md
```

### Target Structure — 목표 구조

```
lang/
├── unified/               ← default (bilingual / 영문/국문 병기 유지)
│   ├── principal/
│   ├── agents/
│   ├── scaffold/
│   └── context/
├── ko/                    ← Korean only / 국문 전용
│   ├── principal/
│   ├── agents/
│   ├── scaffold/
│   └── context/
└── en/                    ← English only / 영문 전용
    ├── principal/
    ├── agents/
    ├── scaffold/
    └── context/
```

### Behavior (CLI) — 동작 방식 (CLI 쪽에서 처리)

- `charlie init` (no --lang): Use `lang/unified/` (default, bilingual)
  `charlie init` (--lang 없음): `lang/unified/` 사용 (기존 동작, 병기 버전)
- `charlie init --lang ko`: Install `lang/ko/` contents to `.charlie/`
  `charlie init --lang ko`: `lang/ko/` 내용을 `.charlie/`로 설치
- `charlie init --lang en`: Install `lang/en/` contents to `.charlie/`
  `charlie init --lang en`: `lang/en/` 내용을 `.charlie/`로 설치

**CLI's loader.go is unchanged** — always reads from `.charlie/principal/`. Only what gets placed there at init time differs.
**CLI의 loader.go는 변경 없음** — 항상 `.charlie/principal/`에서 읽음. init 시점에 어떤 파일이 거기 들어갈지만 달라지는 것.

### Task Instructions — 작업 지시

1. **Keep `lang/unified/`**: Leave bilingual version as-is. Default when `--lang` is not specified.
   **`lang/unified/` 유지**: 현재 병기 버전 그대로 둔다. `--lang` 미지정 시 기본값.

2. **Create `lang/en/`**: Copy from unified, remove Korean to create English-only. Includes scaffold/ and context/.
   **`lang/en/` 생성**: unified에서 복사 후 국문 제거. scaffold/와 context/도 포함.

3. **Create `lang/ko/`**: Copy from unified, remove English to create Korean-only. Includes scaffold/ and context/.
   **`lang/ko/` 생성**: unified에서 복사 후 영문 제거. scaffold/와 context/도 포함.

4. **Maintain file structure**: File names, directory structure, and frontmatter format must be identical across all lang directories.
   **파일 구조 유지**: 각 언어 디렉토리의 파일명, 디렉토리 구조, frontmatter 형식은 동일해야 한다.

5. **SKILL.md parsing compatibility**: CLI-parsed text (frontmatter keys, `[VERDICT]`) must remain in English.
   **SKILL.md 파싱 호환**: CLI 파싱 대상 텍스트는 언어와 무관하게 영문으로 유지.

### Decisions Needed — 판단이 필요한 부분

- Ambiguous bilingual split criteria (e.g., comments inside code examples, technical terms)
  병기 파일에서 영문/국문을 분리하는 기준이 모호한 경우
- If some files are bilingual and others are single-language — how to handle
  파일 중 일부만 병기이고 나머지는 단일 언어인 경우

---

## Work Order — 작업 순서

```
Phase 1: Part 1 (A3~C2) / 1단계: 파트 1
  ├── review/SKILL.md (A3, A4)
  ├── agents/reviewer.md (A5)
  ├── plan/SKILL.md (B1)
  ├── agents/planner.md (B2)
  └── implement/SKILL.md (C1, C2)

Phase 2: Part 2 (multilingual split) — Done / 2단계: 파트 2 (다국어 분리) — 완료
  ├── lang/unified/ (bilingual / 통합본, 병기)
  ├── lang/ko/ (Korean only / 한국어 전용)
  └── lang/en/ (English only / 영어 전용)
```

Part 1 modifies existing files — can start immediately.
파트 1은 기존 파일 수정이므로 바로 착수 가능.

Part 2 is a structural change — understand bilingual patterns first, then confirm split criteria with user.
파트 2는 구조 변경이므로, 먼저 현재 병기 패턴을 파악한 뒤 분리 기준을 유저에게 확인받고 진행.
