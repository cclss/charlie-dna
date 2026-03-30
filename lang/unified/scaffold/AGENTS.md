# AGENTS.md

> STATUS: CONFIRMED

이 프로젝트는 Charlie 시스템을 사용한다.
이 파일은 Agent CLI가 가장 먼저 읽는 진입점이다.

---

## Startup

1. `.charlie/override/` 를 확인하라. 활성화된 override가 있으면 우선 따른다.
2. `.charlie/principal/INDEX.md` 를 읽어라.
3. INDEX.md가 안내하는 순서대로 필요한 파일을 읽어라.
4. 모든 파일의 STATUS를 확인하라. CONFIRMED가 아닌 파일은 참조하지 마라.

---

## 명령어

### /onboard

프로젝트 초기 구성. 일회성.

1. `.charlie/principal/skills/onboard/SKILL.md` 를 읽고 따른다.
2. 필수 입력: `.charlie/context/masterplan.md`
3. 선택 입력: `--context` 로 전달된 추가 자료.

### /done

세션 종료.

1. `.charlie/principal/skills/handoff/SKILL.md` 를 읽고 따른다.

### /fix

reviewer가 FAIL 판정한 항목을 수정한다.

1. `.charlie/context/runs/{session-id}/fix-plan.md` 를 읽는다.
2. fix-plan이 지시하는 범위만 `.charlie/principal/skills/implement/SKILL.md` 를 따라 재실행한다.

---

## 수정 불가

다음 디렉토리의 파일은 절대 수정하지 않는다.
이 파일들은 `charlie dna update` 로만 변경된다.

- `.charlie/principal/`
- `.charlie/agents/`

---

## 골든 룰

- 확정되지 않은 것을 기반으로 다음을 진행하지 마라.
- 추측으로 빈 칸을 채우지 마라.
- 모르면 멈추고 물어라.
