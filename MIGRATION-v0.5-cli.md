# CLI Migration Guide: DNA v0.5 Breaking Changes

> 대상: charlie-cli
> 날짜: 2026-03-30
> 관련 커밋: `75699c4` (charlie-dna)
> 이 문서는 Claude에게 charlie-cli 수정을 맡기기 위한 가이드

---

## 요약

charlie-dna의 디렉토리 구조가 **flat → lang/ 그룹핑**으로 변경되었다.
CLI에서 DNA 파일을 읽어 프로젝트에 설치하는 모든 경로가 영향받는다.

---

## 변경 전후 비교

### Before (v0.4)

```
charlie-dna/
├── principal/          ← 통합본 (병기)
├── principal-ko/       ← 한국어
├── principal-en/       ← 영어
├── agents/             ← 통합본
├── agents-ko/
├── agents-en/
├── scaffold/           ← 단일 (한국어만)
├── context/            ← 단일 (한국어만)
└── scripts/
```

### After (v0.5)

```
charlie-dna/
├── lang/
│   ├── unified/        ← 통합본 (영문/국문 병기)
│   │   ├── principal/
│   │   ├── agents/
│   │   ├── scaffold/
│   │   └── context/
│   ├── ko/             ← 한국어 전용
│   │   ├── principal/
│   │   ├── agents/
│   │   ├── scaffold/
│   │   └── context/
│   └── en/             ← 영어 전용
│       ├── principal/
│       ├── agents/
│       ├── scaffold/
│       └── context/
└── scripts/
```

---

## CLI에서 바꿔야 하는 것

### 1. DNA 소스 경로 매핑 (최우선)

CLI가 DNA repo에서 파일을 읽어 프로젝트에 복사하는 경로를 모두 변경해야 한다.

| 기능 | Before | After |
|------|--------|-------|
| `charlie init` (기본) | `principal/` | `lang/unified/principal/` |
| `charlie init` (기본) | `agents/` | `lang/unified/agents/` |
| `charlie init` (기본) | `scaffold/` | `lang/unified/scaffold/` |
| `charlie init` (기본) | `context/` | `lang/unified/context/` |
| `charlie init --lang ko` | `principal-ko/` | `lang/ko/principal/` |
| `charlie init --lang ko` | `agents-ko/` | `lang/ko/agents/` |
| `charlie init --lang ko` | ~~scaffold 없었음~~ | `lang/ko/scaffold/` |
| `charlie init --lang ko` | ~~context 없었음~~ | `lang/ko/context/` |
| `charlie init --lang en` | `principal-en/` | `lang/en/principal/` |
| `charlie init --lang en` | `agents-en/` | `lang/en/agents/` |
| `charlie init --lang en` | ~~scaffold 없었음~~ | `lang/en/scaffold/` |
| `charlie init --lang en` | ~~context 없었음~~ | `lang/en/context/` |
| `charlie dna update` | 위와 동일한 경로 변경 적용 | |

**핵심 변경**: `--lang ko`/`--lang en` 시 scaffold과 context도 해당 언어 버전을 설치해야 한다.
기존에는 scaffold/context가 언어 구분 없이 하나만 있었으므로 항상 같은 것을 복사했지만,
이제는 `lang/{lang}/scaffold/`, `lang/{lang}/context/`에서 가져와야 한다.

### 2. 경로 해석 로직 단순화

기존에는 언어별로 다른 디렉토리 이름을 사용했다:
```go
// Before: 언어별로 다른 접두사/접미사 패턴
srcPrincipal = "principal"        // 기본
srcPrincipal = "principal-ko"     // --lang ko
srcPrincipal = "principal-en"     // --lang en
srcAgents    = "agents"           // 기본
srcAgents    = "agents-ko"        // --lang ko
// ... 각각 개별 매핑
```

이제는 단일 패턴으로 통일 가능:
```go
// After: lang 변수 하나로 모든 경로 결정
langDir = "unified"  // 기본
langDir = "ko"       // --lang ko
langDir = "en"       // --lang en

srcBase = fmt.Sprintf("lang/%s", langDir)
srcPrincipal = filepath.Join(srcBase, "principal")
srcAgents    = filepath.Join(srcBase, "agents")
srcScaffold  = filepath.Join(srcBase, "scaffold")
srcContext   = filepath.Join(srcBase, "context")
```

### 3. 설치 대상 변경 없음

프로젝트 측 `.charlie/` 구조는 **변경 없음**. 설치 대상은 여전히:
- `lang/{lang}/principal/` → `.charlie/principal/`
- `lang/{lang}/agents/` → `.charlie/agents/`
- `lang/{lang}/context/` → `.charlie/context/`
- `lang/{lang}/scaffold/AGENTS.md` → `AGENTS.md` (프로젝트 루트)
- `lang/{lang}/scaffold/learning/` → `learning/` (프로젝트 루트)

loader.go는 변경 불필요 — 항상 `.charlie/principal/`에서 읽는다.

### 4. scaffold/context 언어별 설치 (신규 동작)

**Before**: `--lang` 플래그는 principal과 agents에만 영향을 줬다. scaffold/context는 항상 같은 것을 복사.

**After**: `--lang` 플래그가 scaffold/context에도 영향을 준다. 한국어 프로젝트에는 한국어 AGENTS.md가, 영어 프로젝트에는 영어 AGENTS.md가 설치된다.

---

## 영향받는 CLI 파일 (추정)

CLI 코드를 직접 확인 후 정확한 파일을 특정해야 하지만, 예상되는 영향 범위:

| 영역 | 예상 파일 | 변경 내용 |
|------|----------|----------|
| init 명령 | `cmd/init.go` 또는 유사 | 소스 경로 매핑 변경 |
| dna update 명령 | `cmd/update.go` 또는 유사 | 소스 경로 매핑 변경 |
| DNA 다운로더/복사기 | `internal/dna/` 또는 유사 | 경로 해석 로직 변경 |
| 테스트 | 관련 테스트 파일 | fixture 경로 업데이트 |

---

## 테스트 체크리스트

- [ ] `charlie init` (--lang 없음): `lang/unified/`에서 올바르게 설치되는가
- [ ] `charlie init --lang ko`: `lang/ko/`에서 principal, agents, **scaffold, context** 모두 설치되는가
- [ ] `charlie init --lang en`: `lang/en/`에서 모두 설치되는가
- [ ] `charlie dna update`: 새 경로에서 올바르게 업데이트되는가
- [ ] 설치된 `.charlie/` 내부 구조가 이전과 동일한가 (하위 호환)
- [ ] AGENTS.md가 올바른 언어로 프로젝트 루트에 배치되는가
- [ ] learning/ 디렉토리가 올바른 언어로 배치되는가

---

## 하위 호환성

- 프로젝트 측 `.charlie/` 구조는 변경 없음 → 기존 프로젝트에 영향 없음
- DNA v0.4 이하와 CLI 호환은 깨짐 → CLI가 새 DNA 버전을 요구하도록 버전 체크 필요
- `config.yaml`의 `dna` 버전을 `v0.5.0`으로 올리고, CLI에서 `v0.5.0` 이상일 때 새 경로 사용

---

## 요약: Claude에게 전달할 핵심 지시

1. CLI에서 DNA 파일을 읽는 모든 경로를 `lang/{unified|ko|en}/` 접두사로 변경하라.
2. `--lang` 플래그가 이제 scaffold과 context에도 적용된다. 기존에 scaffold/context를 언어 무관하게 복사하던 로직을 수정하라.
3. 경로 해석을 단일 `langDir` 변수로 단순화하라.
4. loader.go와 프로젝트 측 `.charlie/` 구조는 건드리지 마라.
5. DNA 버전 체크 로직에 v0.5.0 대응을 추가하라.
