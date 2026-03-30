# Onboarding

> STATUS: DRAFT

여기서부터 읽어라.
이 프로젝트를 처음 접하는 사람(인간이든 AI든)을 위한 탐색 가이드.

---

## .charlie/ 구조

```
.charlie/
├── principal/        불변의 Charlie DNA. 프로젝트 독립적.
│   ├── INDEX.md        진입점. 로딩 순서 안내.
│   ├── ai-protocol.md  AI 작업 규칙.
│   ├── philosophy.md   왜 이렇게 일하는가.
│   ├── engineering.md  공학 원칙.
│   ├── collaboration.md 협업 규칙.
│   ├── security.md     보안 원칙.
│   └── skills/         행동 정의.
├── agents/           subagent 역할 정의. 불변.
├── override/         principal에 대한 추가 지시. 인간만 작성.
├── context/          프로젝트 상태. 살아있는 문서.
├── memory/           세션 요약. Charlie가 자동 기록.
├── config.yaml       팀 설정 (dna 버전, mode 등).
└── config.local.yaml 로컬 설정 (gitignore).
```

---

## 읽는 순서

1. 이 파일 (`learning/onboarding/README.md`)
2. `learning/before-you-start/gotchas.md` — 함정과 주의사항.
3. `learning/before-you-start/conventions.md` — 암묵적 규칙.
4. `.charlie/context/overview.md` — 프로젝트가 무엇인가.
5. `.charlie/context/architecture.md` — 기술 구조.
6. `.charlie/context/boundaries.md` — 하지 말아야 할 것.
7. `learning/onboarding/architecture-tour.md` — 구조 이해 가이드.
8. `learning/adr/` — 최근 결정을 훑어라.

---

<!-- onboard 시 프로젝트에 맞게 채워진다 -->
