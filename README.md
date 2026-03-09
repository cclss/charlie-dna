# charlie-dna

Charlie의 템플릿 DNA 저장소.

`.charlie/` 안에 들어가는 모든 파일의 템플릿과 기본 내용을 정의하고 버전관리한다.

---

## charlie-dna가 하는 일

- `charlie init` 실행 시 이 저장소의 특정 버전을 가져와 프로젝트에 심는다.
- 프로젝트의 `.charlie/config.yaml` 에 버전이 기록된다.
- `charlie dna update` 로 새 버전 템플릿을 반영할 수 있다.

## charlie-dna가 아닌 것

- 실행 가능한 코드가 없다.
- CLI도 없다. 바이너리도 없다.
- 오직 Markdown 파일들의 모음이다.

---

## 구조

```
charlie-dna/
├── principal/                          → .charlie/principal/
│   ├── INDEX.md                          진입점. 로딩 순서 안내.
│   ├── philosophy.md                     왜 이렇게 일하는가.
│   ├── ai-protocol.md                    AI 작업 규칙.
│   ├── engineering.md                    공학 원칙.
│   ├── collaboration.md                  협업 규칙.
│   ├── security.md                       보안 원칙.
│   └── skills/                           행동 정의.
│       ├── plan/SKILL.md
│       ├── implement/SKILL.md
│       ├── review/SKILL.md
│       ├── handoff/SKILL.md
│       └── onboard/SKILL.md
├── agents/                             → .charlie/agents/
│   ├── planner.md
│   ├── implementer.md
│   └── reviewer.md
├── context/                            → .charlie/context/ (빈 템플릿)
│   ├── overview.md
│   ├── architecture.md
│   ├── boundaries.md
│   ├── changelog.md
│   ├── backlog.md
│   └── roadmap.md
├── scaffold/                           → [project]/ 루트에 배치
│   ├── AGENTS.md
│   └── learning/
│       ├── before-you-start/
│       │   ├── gotchas.md
│       │   └── conventions.md
│       ├── adr/
│       │   └── 0000-template.md
│       ├── cookbook/
│       ├── postmortem/
│       │   └── template.md
│       └── onboarding/
│           ├── README.md
│           └── architecture-tour.md
├── CHANGELOG.md
└── README.md
```

### 네임스페이싱 규칙

| 레포 경로 | 배치 위치 | 비고 |
|-----------|----------|------|
| `principal/` | `.charlie/principal/` | 불변. skills/ 포함. |
| `agents/` | `.charlie/agents/` | 불변. |
| `context/` | `.charlie/context/` | 빈 템플릿. onboard 시 채워짐. |
| `scaffold/learning/` | `learning/` | 프로젝트 루트. |
| `scaffold/AGENTS.md` | `AGENTS.md` | 프로젝트 루트. |

---

## 버전관리

```yaml
# 프로젝트의 .charlie/config.yaml
dna: v1.0.0
```

| 버전 | 의미 |
|------|------|
| v1.0.0 | 초기 안정 릴리즈. |
| v1.x.0 | 마이너. 내용 개선. 하위 호환. |
| v2.0.0 | 메이저. 구조 변경. 마이그레이션 가이드 제공. |
