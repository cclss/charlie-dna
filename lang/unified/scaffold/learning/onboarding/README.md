# Onboarding

> STATUS: DRAFT

Start here.
여기서부터 읽어라.

An exploration guide for anyone (human or AI) encountering this project for the first time.
이 프로젝트를 처음 접하는 사람(인간이든 AI든)을 위한 탐색 가이드.

---

## .charlie/ Structure — .charlie/ 구조

```
.charlie/
├── principal/        Immutable Charlie DNA. Project-independent.
│                     불변의 Charlie DNA. 프로젝트 독립적.
│   ├── INDEX.md        Entry point. Specifies loading order.
│   │                   진입점. 로딩 순서 안내.
│   ├── ai-protocol.md  AI work rules. / AI 작업 규칙.
│   ├── philosophy.md   Why we work this way. / 왜 이렇게 일하는가.
│   ├── engineering.md  Engineering principles. / 공학 원칙.
│   ├── collaboration.md Collaboration rules. / 협업 규칙.
│   ├── security.md     Security principles. / 보안 원칙.
│   └── skills/         Behavior definitions. / 행동 정의.
├── agents/           Subagent role definitions. Immutable.
│                     subagent 역할 정의. 불변.
├── override/         Additional directives for principal. Human-authored only.
│                     principal에 대한 추가 지시. 인간만 작성.
├── context/          Project state. Living documents.
│                     프로젝트 상태. 살아있는 문서.
├── memory/           Session summaries. Auto-recorded by Charlie.
│                     세션 요약. Charlie가 자동 기록.
├── config.yaml       Team settings (dna version, mode, etc.).
│                     팀 설정 (dna 버전, mode 등).
└── config.local.yaml Local settings (gitignored).
                      로컬 설정 (gitignore).
```

---

## Reading Order — 읽는 순서

1. This file (`learning/onboarding/README.md`)
   이 파일 (`learning/onboarding/README.md`)
2. `learning/before-you-start/gotchas.md` — Traps and caveats. / 함정과 주의사항.
3. `learning/before-you-start/conventions.md` — Implicit rules. / 암묵적 규칙.
4. `.charlie/context/overview.md` — What the project is. / 프로젝트가 무엇인가.
5. `.charlie/context/architecture.md` — Technical structure. / 기술 구조.
6. `.charlie/context/boundaries.md` — What not to do. / 하지 말아야 할 것.
7. `learning/onboarding/architecture-tour.md` — Architecture comprehension guide. / 구조 이해 가이드.
8. `learning/adr/` — Skim recent decisions. / 최근 결정을 훑어라.

---

<!-- Populated with project-specific content during onboard -->
<!-- onboard 시 프로젝트에 맞게 채워진다 -->
