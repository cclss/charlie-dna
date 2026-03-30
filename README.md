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
├── lang/
│   ├── unified/                        통합본 (영문/국문 병기)
│   │   ├── principal/                  → .charlie/principal/
│   │   │   ├── INDEX.md
│   │   │   ├── philosophy.md
│   │   │   ├── ai-protocol.md
│   │   │   ├── engineering.md
│   │   │   ├── collaboration.md
│   │   │   ├── security.md
│   │   │   └── skills/
│   │   │       ├── plan/SKILL.md
│   │   │       ├── implement/SKILL.md
│   │   │       ├── review/SKILL.md
│   │   │       ├── handoff/SKILL.md
│   │   │       └── onboard/SKILL.md
│   │   ├── agents/                     → .charlie/agents/
│   │   │   ├── planner.md
│   │   │   ├── implementer.md
│   │   │   └── reviewer.md
│   │   ├── context/                    → .charlie/context/ (빈 템플릿)
│   │   │   ├── overview.md
│   │   │   ├── architecture.md
│   │   │   ├── boundaries.md
│   │   │   ├── changelog.md
│   │   │   ├── backlog.md
│   │   │   └── roadmap.md
│   │   └── scaffold/                   → [project]/ 루트에 배치
│   │       ├── AGENTS.md
│   │       └── learning/
│   │           ├── before-you-start/
│   │           │   ├── gotchas.md
│   │           │   └── conventions.md
│   │           ├── adr/
│   │           │   └── 0000-template.md
│   │           ├── postmortem/
│   │           │   └── template.md
│   │           └── onboarding/
│   │               ├── README.md
│   │               └── architecture-tour.md
│   ├── ko/                             한국어 전용
│   │   ├── principal/
│   │   ├── agents/
│   │   ├── context/
│   │   └── scaffold/
│   └── en/                             영어 전용
│       ├── principal/
│       ├── agents/
│       ├── context/
│       └── scaffold/
├── scripts/
├── CHANGELOG.md
└── README.md
```

### 언어 선택

| CLI 명령 | 소스 디렉토리 | 설명 |
|----------|-------------|------|
| `charlie init` | `lang/unified/` | 기본값. 영문/국문 병기. |
| `charlie init --lang ko` | `lang/ko/` | 한국어 전용. |
| `charlie init --lang en` | `lang/en/` | 영어 전용. |

각 언어 디렉토리는 동일한 파일 구조를 가진다. CLI의 loader는 항상 `.charlie/principal/`에서 읽으므로, init 시점에 어떤 언어 파일이 설치되는지만 달라진다.

### 네임스페이싱 규칙

| 레포 경로 (lang/{lang}/ 하위) | 배치 위치 | 비고 |
|-------------------------------|----------|------|
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
